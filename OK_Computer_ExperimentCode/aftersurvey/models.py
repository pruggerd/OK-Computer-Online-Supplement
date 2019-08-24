from otree.api import (
    models, widgets, BaseConstants, BaseSubsession, BaseGroup, BasePlayer,
    Currency as c, currency_range
)

import random

from otree.models import player

author = 'Dominik'

doc = """
This app functions as the after-experiment survey for the trial in MTurk for "OK Computer" """


def make_likert():
    return models.IntegerField(
        choices =[
            [1, 'Strongly agree'],
            [2, 'Agree'],
            [3, 'Mildly agree'],
            [4, 'Neutral'],
            [5, 'Mildly disagree'],
            [6, 'Disagree'],
            [7, 'Strongly disagree'],
            [0, 'I do not understand the question'],

        ]
    )

class Constants(BaseConstants):
    name_in_url = 'aftersurvey'
    players_per_group = None
    num_rounds = 1


class Subsession(BaseSubsession):
    pass


class Group(BaseGroup):
    pass


class Player(BasePlayer):

    test1 = models.IntegerField(
        choices=[
            [0, 'yes'],
            [1, 'no' ]
        ]
    )

    choice1 = models.IntegerField(
    )

    explanation = models.LongStringField(
    )

    choice2 = models.IntegerField(
    )

    fair = make_likert()
    transparent = make_likert()
    simpler = make_likert()
    familiar = make_likert()
    characteristics = make_likert()
    previous_performance = make_likert()
    discriminate = make_likert()
    quickly = make_likert()
    error = make_likert()
    other = make_likert()

   #Define the random variables for the likert randomization
    x1 = models.IntegerField()
    x2 = models.IntegerField()
    x3 = models.IntegerField()
    x4 = models.IntegerField()
    x5 = models.IntegerField()



    def set_x1(self):
        self.x1 = random.randint(0,1)

    def set_x2(self):
        self.x2 = random.randint(0,1)

    def set_x3(self):
        self.x3 = random.randint(0,1)

    def set_x4(self):
        self.x4 = random.randint(0,1)

    def set_x5(self):
        self.x5 = random.randint(0,1)

