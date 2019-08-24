from typing import List
import random
from otree.api import Currency as c, currency_range
from ._builtin import Page, WaitPage
from .models import Constants


class Introduction(Page):
    pass


class Questionaire(Page):
    form_model = 'player'
    form_fields = ['age', 'gender', 'nationality', 'ethnicity', 'residency', 'education', ]

    def before_next_page(self):
        self.player.set_participant()




page_sequence = [
    Introduction,
    Questionaire,

]
