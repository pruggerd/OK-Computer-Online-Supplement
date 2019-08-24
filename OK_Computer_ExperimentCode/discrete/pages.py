from otree.api import Currency as c, currency_range
from ._builtin import Page, WaitPage
from .models import Constants


class Introduction(Page):
    form_model = 'player'
    form_fields = ['test_intro1', 'test_intro2', 'test_intro3']
    def vars_for_template(self):
        return {
            'time9': self.participant.vars['t9'],
            'treatment': self.player.treatment
        }

    #def error_message(self, values):
    #    newlist = (values['test_intro1'], values['test_intro2'])
    #    if (1,1) != newlist:
    #        return 'Your answer is NOT correct! Please read the instructions again carefully and answer the two questions'


class Introduction2(Page):
    pass

    def before_next_page(self):
        self.player.setrand_choice()

class Discrete(Page):
    form_model = 'player'
    form_fields = ['choice1']
    def vars_for_template(self):
        return {
            'time9': self.participant.vars['t9'],
            'treatment': self.player.treatment
        }

    def before_next_page(self):
        self.player.set_choice()

class Belief(Page):
    form_model = 'player'
    form_fields = ['test_belief1', 'test_belief2']


    def vars_for_template(self):
        self.player.ethnicity2 = self.participant.vars['ethnicity']
        self.player.gender2 = self.participant.vars['gender']
        self.player.age2 = self.participant.vars['age']
        self.player.education2 = self.participant.vars['education']

        return{
            'choice': self.player.choice1,
            'time9': self.participant.vars['t9'],
            'ethnicity': self.participant.vars['ethnicity']
        }
    #def error_message(self, values):
     #   newlist = (values['test_belief1'], values['test_belief2'])
      #  if newlist != (0,1):
       #     return 'Your answer is NOT correct! Please read the instructions again carefully and answer the two questions'

class Belief2(Page):
    form_model = 'player'
    form_fields = ['beliefalgorithm','beliefhuman']


    def vars_for_template(self):
        self.player.ethnicity2 = self.participant.vars['ethnicity']
        self.player.gender2 = self.participant.vars['gender']
        self.player.age2 = self.participant.vars['age']
        self.player.education2 = self.participant.vars['education']

        return{
            'choice': self.player.choice1,
            'time9': self.participant.vars['t9'],
            'ethnicity': self.participant.vars['ethnicity']
        }


    def before_next_page(self):
        #self.participant.vars['predalg'] = round(9.69882 + 0.68671*self.player.age2 - -3.75093*self.player.gender2 +
        #                                         0.53899 * self.participant.vars['t9'],2)

        self.player.set_gender2()
        self.player.set_time_human()
        self.player.predalg = round(9.69882 + 0.68671*self.player.age2 - 3.75093*self.player.gender2 + 0.53899 * self.participant.vars['t9'], 2)
        self.player.payoff_belief = round(200-((self.player.beliefalgorithm - self.player.predalg)*(self.player.beliefalgorithm -
                                                                                                 self.player.predalg)), 2)/100
        self.player.set_time9()


class Belief3(Page):
    form_model = 'player'
    form_fields = ['beliefalgorithm','beliefhuman', 'accuracyhuman', 'accuracyalgorithm']


    def vars_for_template(self):
        self.player.ethnicity2 = self.participant.vars['ethnicity']
        self.player.gender2 = self.participant.vars['gender']
        self.player.age2 = self.participant.vars['age']
        self.player.education2 = self.participant.vars['education']

        return{
            'choice': self.player.choice1,
            'time9': self.participant.vars['t9'],
            'ethnicity': self.participant.vars['ethnicity']
        }


    def before_next_page(self):
        #self.participant.vars['predalg'] = round(9.69882 + 0.68671*self.player.age2 - -3.75093*self.player.gender2 +
        #                                         0.53899 * self.participant.vars['t9'],2)

        self.player.set_belief()
        self.player.set_education()
        self.player.set_time_human()
        self.player.sethuman()
        self.player.set_ethnicity()
        self.player.predalg = round(6.43 + 0.75*self.player.age2 - 4.1*self.player.gender2 + 0.53 * self.participant.vars['t9'] +
                                    0.71 * self.player.education2 - 1.03 * self.player.ethnicity2, 2)
        self.player.payoff_belief_a = round(100-((self.player.beliefalgorithm - self.player.predalg)*(self.player.beliefalgorithm -
                                                                                                 self.player.predalg)), 2)/100
        self.player.payoff_choice_a = round((90-self.player.predalg)/60, 2)
        self.player.payoff_belief_h = round(100 - ((self.player.beliefhuman - self.player.predhum)*(self.player.beliefhuman - self.player.predhum))
                                            , 2)/100
        self.player.payoff_choice_h = round((90 - self.player.predalg)/60, 2)
        self.player.setpayoff_belief()
        self.player.setpayoff_choice()
        self.player.setpayoff_global()


class Results(Page):
    form_model = 'player'
    def vars_for_template(self):
        return {
            'timealg': self.player.predalg,
            'timehum': self.player.predhum,
            'belief_a': self.player.beliefalgorithm,
            'belief_h': self.player.beliefhuman,
            'payoff_a': self.player.payoff_belief_a,
            'payoff_h': self.player.payoff_belief_h,
            'time9': self.participant.vars['t9'],
            'timehum': self.player.predhum,
            'test' : self.player.test,
            'gender': self.player.gender2,
            'test2': self.player.test2
        }


page_sequence = [
    Introduction,
    Introduction2,
    Discrete,
    Belief,
    Belief3,
    Results
]
