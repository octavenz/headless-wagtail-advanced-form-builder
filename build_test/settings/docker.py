import os
from .dev import *

# Override settings for Docker environment

# Database
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.environ.get('POSTGRES_DB', 'waf_pg_db'),
        'USER': os.environ.get('POSTGRES_USER', 'waf_pg_db'),
        'PASSWORD': os.environ.get('POSTGRES_PASSWORD', 'waffity'),
        'HOST': os.environ.get('POSTGRES_HOST', 'db'),
        'PORT': os.environ.get('POSTGRES_PORT', '5432'),
        'CONN_MAX_AGE': 600,
    }
}

# Cache (using Redis instead of memcached)
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.redis.RedisCache',
        'LOCATION': os.environ.get('REDIS_URL', 'redis://redis:6379/0'),
    }
}

# Email settings for Docker
EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = os.environ.get('EMAIL_HOST', 'mailhog')
EMAIL_PORT = int(os.environ.get('EMAIL_PORT', 1025))
EMAIL_USE_TLS = False
EMAIL_USE_SSL = False

# Security - allow Docker internal networking
ALLOWED_HOSTS = ['*']

# Static files - ensure they're collected properly
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')

# Secret key from environment or default
SECRET_KEY = os.environ.get('SECRET_KEY', 'ooolalalasecretsecrets-docker-dev-key')

# Admin URL
WAGTAILADMIN_BASE_URL = os.environ.get('WAGTAILADMIN_BASE_URL', 'http://localhost:8000') 