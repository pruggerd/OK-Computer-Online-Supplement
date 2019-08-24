from otree.api import Currency as c, currency_range
from otree.models import player

from ._builtin import Page, WaitPage
from .models import Constants

import random

class Introduction(Page):
    timeout_seconds = 90
    form_model = 'player'
    form_fields = ['test1']
   # def vars_for_template(self):
   #     return{
   #         'random1': random.choice(['blabla1', 'blabla2'])
   #         'random2': random.randint(0, 1)
   #     }


    #def error_message(self, values):
    #    if (values['test1']) == 1:
    #        return 'Your answer is NOT correct! Please try again'



class Discret(Page):
    form_model = 'player'
    form_fields = ['choice1', 'explanation', 'choice2'
                   ]

    def choice1_choices(selfs):
        options = [
            [0, 'Human evaluator'],
            [1, 'Algorithmic evaluator']
        ]
        random.shuffle(options)
        return options

    def choice2_choices(selfs):
        options = [
            [0, 'Human evaluator'],
            [1, 'Algorithmic evaluator']
        ]
        random.shuffle(options)
        return options


    def before_next_page(self):
        for p in self.group.get_players():
            p.set_x1()
        for p in self.group.get_players():
            p.set_x2()
        for p in self.group.get_players():
            p.set_x3()
        for p in self.group.get_players():
            p.set_x4()
        for p in self.group.get_players():
            p.set_x5()




class Likert(Page):
    form_model = 'player'
    form_fields = ['fair', 'transparent', 'simpler', 'familiar', 'characteristics' ,
                   ]

    #for p in self.group.get_players():
    #    p.set_Neuroticism()

    #def randomize(self, x1):
    #    if (self.player.x1 == 0):
    #        return 'Es is eine null'

    #def randomize(self, x1):
    #return self.player.x1 = random.randint(0,1)

    def before_next_page(self):
        for p in self.group.get_players():
            p.set_x1()
        for p in self.group.get_players():
            p.set_x2()
        for p in self.group.get_players():
            p.set_x3()
        for p in self.group.get_players():
            p.set_x4()
        for p in self.group.get_players():
            p.set_x5()


class Likert2(Page):
    form_model = 'player'
    form_fields = [ 'previous_performance', 'discriminate', 'quickly', 'error',
                   'other'
                   ]

class Results(Page):
    pass


page_sequence = [
    Introduction,
    Discret,
    Likert,
    Likert2,
    Results
]
