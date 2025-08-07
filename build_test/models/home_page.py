from wagtail.models import Page


class HomePage(Page):
    subpage_types = [
        'headless_waf_builder.EmailFormPage',
        'headless_waf_builder.FormPage',
    ]
