package com.vstep.payment;

import java.time.Instant;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

public class PaymentStore {

    public static class PaymentSession {
        private final String token;
        private final long registrationId;
        private final boolean isExam; // true nếu là đăng ký ca thi, false nếu là lớp ôn
        private final long expiresAtEpochMillis;
        private volatile boolean used;

        public PaymentSession(String token, long registrationId, boolean isExam, long expiresAtEpochMillis) {
            this.token = token;
            this.registrationId = registrationId;
            this.isExam = isExam;
            this.expiresAtEpochMillis = expiresAtEpochMillis;
            this.used = false;
        }

        public String getToken() {
            return token;
        }

        public long getRegistrationId() {
            return registrationId;
        }

        public boolean isExam() {
            return isExam;
        }

        public long getExpiresAtEpochMillis() {
            return expiresAtEpochMillis;
        }

        public boolean isUsed() {
            return used;
        }

        public void markUsed() {
            this.used = true;
        }

        public boolean isExpired() {
            return Instant.now().toEpochMilli() > expiresAtEpochMillis;
        }
    }

    private static final long DEFAULT_TTL_MILLIS = 5 * 60 * 1000; // 5 minutes
    private static final Map<String, PaymentSession> TOKEN_TO_SESSION = new ConcurrentHashMap<>();

    public static PaymentSession create(long registrationId) {
        return create(registrationId, false);
    }

    public static PaymentSession create(long registrationId, boolean isExam) {
        String token = UUID.randomUUID().toString().replace("-", "");
        long expiresAt = Instant.now().toEpochMilli() + DEFAULT_TTL_MILLIS;
        PaymentSession session = new PaymentSession(token, registrationId, isExam, expiresAt);
        TOKEN_TO_SESSION.put(token, session);
        return session;
    }

    public static PaymentSession get(String token) {
        if (token == null || token.isBlank()) return null;
        return TOKEN_TO_SESSION.get(token);
    }

    public static void invalidate(String token) {
        if (token == null) return;
        TOKEN_TO_SESSION.remove(token);
    }
}


