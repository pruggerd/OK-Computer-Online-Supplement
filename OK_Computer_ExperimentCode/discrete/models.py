from otree.api import (
    models, widgets, BaseConstants, BaseSubsession, BaseGroup, BasePlayer,
    Currency as c, currency_range,
)

import itertools, csv, random
import numpy as np
import pandas as pd
import csv


author = 'Dominik Prugger'

doc = """
This app faces introduces and faces the participant with the choice between the human and the algorithmic evaluation"""


class Constants(BaseConstants):
    name_in_url = 'discrete'
    players_per_group = None
    num_rounds = 1

    with open('discrete/df1.csv') as human1_file:
        human1 = list(csv.DictReader(human1_file))



class Subsession(BaseSubsession):
    def creating_session(self):
        treatmentoptions = itertools.cycle(['baseline', 'transp'])
        for p in self.get_players():
            p.treatment = next(treatmentoptions)


class Group(BaseGroup):
    pass


class Player(BasePlayer):
    test_intro1 = models.IntegerField(
        widget = widgets.RadioSelectHorizontal,
        choices=[[0, 'no'], [1, 'yes']]
    )

    test_intro2 = models.IntegerField(
        widget = widgets.RadioSelectHorizontal,
        choices=[[0, 'no'], [1, 'yes']]
    )

    test_intro3 = models.IntegerField(
        widget=widgets.RadioSelectHorizontal,
        choices=[[0, 'false'], [1, 'true']]
    )

    test_belief1 = models.IntegerField(
        widget = widgets.RadioSelectHorizontal,
        choices=[[0, 'false'], [1, 'true']]
    )

    test_belief2 = models.IntegerField(
        widget = widgets.RadioSelectHorizontal,
        choices=[[0, 'false'], [1, 'true']]
    )

    time9 = models.FloatField()

    choice1 = models.IntegerField(widget = widgets.RadioSelectHorizontal, choices=[[0, 'Human evaluator'], [1, 'Algorithmic evaluator']])
    rand_choice = models.IntegerField()


    predalg = models.FloatField()
    predhum = models.FloatField()

    beliefalgorithm = models.IntegerField(min= 0, max = 90)
    beliefhuman= models.IntegerField(min = 0, max = 90)


    gender2 = models.IntegerField()
    ethnicity2 = models.IntegerField()
    age2 = models.IntegerField()
    education2 = models.IntegerField()


    payoff_belief_a = models.CurrencyField()
    payoff_choice_a = models.CurrencyField()
    payoff_belief_h = models.CurrencyField()
    payoff_choice_h = models.CurrencyField()
    payoff_belief   = models.CurrencyField()
    payoff_choice   = models.CurrencyField()

    accuracyalgorithm = models.IntegerField(min = 0, max = 100)
    accuracyhuman = models.IntegerField(min = 0, max = 100)

    treatment = models.StringField()

    test = models.FloatField()
    test2 = models.FloatField()

    random_draw = models.IntegerField()

    def set_time9(self):
        self.participant.vars['t9'] = self.time9

    def set_gender2(self):
        self.gender2 = self.participant.vars['gender']

    def set_time_human(self):
        self.time9 = self.participant.vars['t9']

    def set_age(self):
        self.age2 = self.participant.vars['age']

    def set_education(self):
        self.education2 = self.participant.vars['education']

    def set_ethnicity(self):
        self.ethnicity2 = self.participant.vars['ethnicity']

    def setalgorithm(self):
        self.predalg = round(9.69882 + 0.68671*self.participant.vars['age'] - -3.75093*self.participant.vars['gender'] +
                                                 0.53899 * self.participant.vars['t9'], 2)


    def set_choice(self):
        self.participant.vars['choice1'] = self.choice1


    def set_belief(self):
        self.participant.vars['beliefhuman'] = self.beliefhuman
        self.participant.vars['beliefalgorithm'] = self.beliefalgorithm


    def sethuman(self):
        data = pd.read_csv('discrete/df1.csv')
        r9 = self.time9
        educ = self.education2
        age = self.age2
        rand = random.randint(1,9)
        subset_gender = data[data.Gender == self.gender2]
        round9 = subset_gender['Round9'].astype('float64')
        data_educ = subset_gender['Education'].astype('float64')
        data_age = subset_gender['Age'].astype('float64')
        X = (np.abs((round9+data_educ + data_educ) -(r9 + educ + age))).argmin()
        X = int(float(X))
        self.test = X
        self.test2 = rand
        self.predhum = data.iloc[X][rand+6]



    #Set the global payoffs for the belief incentivization
    def setpayoff_belief(self):
        self.random_draw = random.randint(0,1)
        if self.payoff_belief_a > 0:
            self.payoff.belief_a = self.payoff_belief_a
        else:
            self.payoff_belief_a = 0

        if self.payoff_belief_h > 0:
            self.payoff.belief_h = self.payoff_belief_h
        else:
            self.payoff_belief_h = 0

        if self.random_draw == 1:
            self.participant.vars['belief_payoff'] = round(self.payoff_belief_a, 2)
            self.payoff_belief_a = round(self.payoff_belief_a, 2)
        else:
            self.participant.vars['belief_payoff'] = round(self.payoff_belief_h, 2)
            self.payoff_belief_h = round(self.payoff_belief_h, 2)


    #Set the global payoffs for the discrete choice

    def setpayoff_choice(self):
        if self.payoff_choice_a > 0:
            self.payoff_choice_a = self.payoff_choice_a
        else:
            self.payoff_choice_a = 0
        if self.payoff_choice_h > 0:
            self.payoff_choice_h = self.payoff_choice_h
        else:
            self.payoff_choice_h = 0

        if self.choice1 == 1:
            self.participant.vars['choice_payoff'] = round(self.payoff_choice_a, 2)
            self.payoff_choice_a = round(self.payoff_choice_a, 2)
        else:
            self.participant.vars['choice_payoff'] = round(self.payoff_choice_h, 2)
            self.payoff_choice_h = round(self.payoff_choice_h, 2)



    #Now set the global payoffs:

    def setpayoff_global(self):
        if self.random_draw == 1 and self.choice1 ==1:
            self.payoff = self.payoff_belief_a + self.payoff_choice_a
        if self.random_draw == 1 and self.choice1 == 0:
            self.payoff = self.payoff_belief_a + self.payoff_choice_h
        if self.random_draw == 0 and self.choice1 == 1:
            self.payoff = self.payoff_belief_h + self.payoff_choice_a
        if self.random_draw == 0 and self.choice1 == 0:
            self.payoff = self.payoff_belief_h+ self.payoff_choice_h

    def setrand_choice(self):
        self.rand_choice = random.randint(0,1)






