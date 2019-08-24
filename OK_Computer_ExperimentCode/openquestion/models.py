from otree.api import (
    models, widgets, BaseConstants, BaseSubsession, BaseGroup, BasePlayer,
    Currency as c, currency_range
)
import random

author = 'Your name here'

doc = """
Your app description
"""


class Constants(BaseConstants):
    name_in_url = 'post_exp_survey'
    players_per_group = None
    num_rounds = 1


class Subsession(BaseSubsession):
    pass


class Group(BaseGroup):
    pass


class Player(BasePlayer):
    test_intro = models.IntegerField(
        choices=[[0, 'yes'], [1, 'no']]
    )

    choice1 = models.IntegerField()
    beliefa = models.IntegerField()
    beliefh = models.IntegerField()


    explanation = models.LongStringField()

    explanation2 = models.LongStringField()


    fair = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                               choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']]
                               )
    transparent = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                      choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                      )
    simpler = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                  choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                  )
    familiar = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                   choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                   )
    characteristics = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                          choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                          )
    previous_performance = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                               choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                               )
    discriminate = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                       choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                       )
    quickly = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                  choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                  )
    error = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                )
    other = models.IntegerField(widget=widgets.RadioSelectHorizontal,
                                choices=[[1, 'Strongly disagree'], [2, 'Disagree'], [3, 'Neither agree nor disagree'],
                                        [4, 'Agree'], [5, 'Strongly agree']],
                                )
    # Define the random variables for the likert randomization
    x1 = models.IntegerField()
    x2 = models.IntegerField()
    x3 = models.IntegerField()
    x4 = models.IntegerField()
    x5 = models.IntegerField()

    def set_x1(self):
        self.x1 = random.randint(0, 1)

    def set_x2(self):
        self.x2 = random.randint(0, 1)

    def set_x3(self):
        self.x3 = random.randint(0, 1)

    def set_x4(self):
        self.x4 = random.randint(0, 1)

    def set_x5(self):
        self.x5 = random.randint(0, 1)
