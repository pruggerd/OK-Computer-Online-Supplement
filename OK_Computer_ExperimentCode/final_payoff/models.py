from otree.api import (
    models, widgets, BaseConstants, BaseSubsession, BaseGroup, BasePlayer,
    Currency as c, currency_range
)

author = 'Your name here'

doc = """
Your app description
"""


class Constants(BaseConstants):
    name_in_url = 'final_payoff'
    players_per_group = None
    num_rounds = 1


class Subsession(BaseSubsession):
    pass


class Group(BaseGroup):
    pass


class Player(BasePlayer):
    #Final_payoff = models.CurrencyField()
    matrix_payoff = models.CurrencyField()
    mpl_payoff = models.CurrencyField()
    belief_payoff = models.CurrencyField()
    belief_choice = models.CurrencyField()

    def set_mpl_payoff(self):
        mpl_payoff = self.participant.vars['mpl_payoff']

    def set_matrix_payoff(self):
        matrix_payoff = self.participant.vars['matrix_payoff']

    def set_belief_payoff(self):
        belief_payoff = self.participant.vars['belief_payoff']

    def set_belief_choice(self):
        choice = self.participant.vars['choice_payoff']

