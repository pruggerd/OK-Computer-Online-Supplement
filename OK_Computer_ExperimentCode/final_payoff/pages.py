from otree.api import Currency as c, currency_range
from ._builtin import Page, WaitPage
from .models import Constants


class MyPage(Page):

    form_model = 'player'



class ResultsWaitPage(WaitPage):

    def before_next_page(self):
       pass

class Results(Page):
    def vars_for_template(self):
       # participation_fee = self.session.config['participation_fee']
        #matrix_payoff = self.participant.vars['matrix_payoff']
        #mpl_payoff = self.participant.vars['mpl_payoff']
       # Final_payoff = self.participant.payoff_plus_participation_fee

        return {
            'matrix_payoff': self.participant.vars['matrix_payoff'],
         #   'mpl_payoff': self.participant.vars['mpl_payoff'],
            'belief_payoff': self.participant.vars['belief_payoff'],
            'choice_payoff': self.participant.vars['choice_payoff'],
            'scl_payoff': self.participant.vars['scl_payoff'],
        }

page_sequence = [
    Results
]
