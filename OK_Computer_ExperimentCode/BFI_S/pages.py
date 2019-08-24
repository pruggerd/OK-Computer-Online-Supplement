from typing import List
import random
from otree.api import Currency as c, currency_range
from ._builtin import Page, WaitPage
from .models import Constants


class Introduction(Page):
    pass

class Questionaire(Page):
    form_model = 'player'
    form_fields = [ 'Worry', 'Nervous', 'Relax',
                   'Talkative', 'Sociable', 'Reserved', 'Original', 'Artistic', 'Active_imagination', 'Rude',
                   'Forgiving', 'Considerate', 'Thorough_job', 'Lazy', 'Efficient'
                   ]




page_sequence = [
    Introduction,
    Questionaire,
    # ResultsWaitPage,
    # Results,
    # End,

]
