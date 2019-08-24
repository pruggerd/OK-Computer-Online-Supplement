from otree.api import Currency as c, currency_range
from ._builtin import Page, WaitPage
from .models import Constants


def before_next_page(self):
    self.player.set_x1()
    self.player.set_x2()
    self.player.set_x3()
    self.player.set_x4()
    self.player.set_x5()


class Introduction(Page):
    form_model = 'player'
    form_fields = ['explanation', 'explanation2']

    def vars_for_template(self):
        self.player.choice1 = self.participant.vars['choice1']
        self.player.beliefa = self.participant.vars['beliefalgorithm']
        self.player.beliefh= self.participant.vars['beliefhuman']
        return {
            'beliefa': self.participant.vars['beliefalgorithm'],
            'beliefh': self.participant.vars['beliefhuman']
        }


class Likert(Page):
    form_model = 'player'
    form_fields = ['fair', 'transparent', 'simpler', 'familiar', 'characteristics','previous_performance',
                   'discriminate', 'quickly', 'error','other']


page_sequence = [
    Introduction,
    Likert
]
