DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': "APP_Inventor_case_base",
        'USER': 'your_user_name',
        'PASSWORD': "your_password",
        'HOST': "your_host_ip",
        'OPTIONS': { 'init_command': 'SET default_storage_engine=INNODB;' }
    }
}

DEBUG = True

SECRET_KEY = 'y0vj*z2@3@53nht9t!hn4jac*$6oufv+w24r65*4vom1a^2cca'

CACHES = {
    "default": {
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "redis://127.0.0.1:6379",
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    }
}