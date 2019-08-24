from otree.api import (
    models, widgets, BaseConstants, BaseSubsession, BaseGroup, BasePlayer,
    Currency as c, currency_range
)
from django import forms
from otree import widgets
from django import template
from django_countries import Countries

from django.contrib.auth import get_user_model
from django.contrib.auth.models import AbstractBaseUser

# UserModel = get_user_model()
# if issubclass(UserModel, AbstractBaseUser):
#   UserModel._default_manager.filter().update(last_login=None)
import random
from decimal import Decimal

author = 'Sarah'

doc = """
Big five short (BFI-S) is a subset of big five consisting of
15 items. The BFI-S has been developed by Gerlitz and Schupp (2005) and was also part
of the 2005 and 2009 waves of the SOEP.
"""


class Constants(BaseConstants):
    name_in_url = 'BFI_S'
    players_per_group = None
    num_rounds = 1
    paying_round = random.randint(1, 10)

    instructions_template = 'BFI_S/Instruction.html'


class Subsession(BaseSubsession):
    pass


class Group(BaseGroup):
    # total_score = models.IntegerField()
    pass


class Player(BasePlayer):

    Worry = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                )

    Nervous = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                  choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                  )
    Relax = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                )
    Talkative = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                    choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                    )
    Sociable = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                   choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                   )
    Reserved = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                   choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                   )
    Original = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                   choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                   )
    Artistic = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                   choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                   )
    Active_imagination = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                             choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                             )
    Rude = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                               choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                               )
    Forgiving = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                    choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                    )
    Considerate = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                      choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                      )
    Thorough_job = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                       choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                       )
    Lazy = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                               choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                               )
    Efficient = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                    choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                    )

    Neuroticism = models.DecimalField(decimal_places=2, max_digits=5)
    Extraversion = models.DecimalField(decimal_places=2, max_digits=5)
    Openness = models.DecimalField(decimal_places=2, max_digits=5)
    Agreeableness = models.DecimalField(decimal_places=2, max_digits=5)
    Conscientiousness = models.DecimalField(decimal_places=2, max_digits=5)

    def player_info(self):
        self.player_Worry = self.Worry
        self.player_Nervous = self.Nervous
        self.player_Relax = self.Relax
        self.player_Talkative = self.Talkative
        self.player_Sociable = self.Sociable
        self.player_Reserved = self.Reserved
        self.player_Original = self.Original
        self.player_Artistic = self.Artistic
        self.player_Active_imagination = self.Active_imagination
        self.player_Rude = self.Rude
        self.player_Forgiving = self.Forgiving
        self.player_Considerate = self.Considerate
        self.player_Thorough_job = self.Thorough_job
        self.player_Lazy = self.Lazy
        self.player_Efficient = self.Efficient

