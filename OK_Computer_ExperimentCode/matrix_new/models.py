from otree.api import (
    models, widgets, BaseConstants, BaseSubsession, BaseGroup, BasePlayer,
    Currency as c, currency_range
)
from decimal import Decimal

author = 'Sarah'

doc = """
Your app description
"""


class Constants(BaseConstants):
    name_in_url = 'matrix_new'
    players_per_group = None
    num_rounds = 1
    solution_q01 = 21
    solution_q02 = 79
    solution_q11 = 63
    solution_q12 = 37
    solution_q21 = 85
    solution_q22 = 15
    solution_q31 = 16
    solution_q32 = 84
    solution_q41 = 3
    solution_q42 = 97
    solution_q51 = 87
    solution_q52 = 13
    solution_q61 = 23
    solution_q62 = 77
    solution_q71 = 4
    solution_q72 = 96
    solution_q81 = 74
    solution_q82 = 26
    solution_q91 = 43
    solution_q92 = 57
    solution_q101 = 20
    solution_q102 = 80
    endowment = 100


class Subsession(BaseSubsession):
    pass


class Group(BaseGroup):
    pass


class Player(BasePlayer):
    answer_q01 = models.IntegerField()
    answer_q02 = models.IntegerField()
    start_time0 = models.FloatField()
    elapsed_time0 = models.FloatField()
    count0 = models.IntegerField()
    is_correct0 = models.BooleanField()
    score = models.DecimalField(max_digits=5, decimal_places=2)

    test_matrix1 = models.IntegerField(
        widget = widgets.RadioSelectHorizontal,
        choices=[[0, 'yes'], [1, 'no']]
    )

    test_matrix2 = models.IntegerField(
        widget=widgets.RadioSelectHorizontal,
        choices=[[0, 'yes'], [1, 'no']]
    )
    answer_q11 = models.IntegerField()
    answer_q12 = models.IntegerField()
    start_time1 = models.FloatField()
    elapsed_time1 = models.FloatField()
    is_correct1 = models.BooleanField()
    count1 = models.IntegerField()
    score1 = models.DecimalField(max_digits=5, decimal_places=2)

    answer_q21 = models.IntegerField()
    answer_q22 = models.IntegerField()
    start_time2 = models.FloatField()
    elapsed_time2 = models.FloatField()
    is_correct2 = models.BooleanField()
    count2 = models.IntegerField()
    score2 = models.DecimalField(max_digits=5, decimal_places=2)

    answer_q31 = models.IntegerField()
    answer_q32 = models.IntegerField()
    start_time3 = models.FloatField()
    elapsed_time3 = models.FloatField()
    is_correct3 = models.BooleanField()
    count3 = models.IntegerField()
    score3 = models.DecimalField(max_digits=5, decimal_places=2)

    answer_q41 = models.IntegerField()
    answer_q42 = models.IntegerField()
    start_time4 = models.FloatField()
    elapsed_time4 = models.FloatField()
    is_correct4 = models.BooleanField()
    count4 = models.IntegerField()
    score4 = models.DecimalField(max_digits=5, decimal_places=2)

    answer_q51 = models.IntegerField()
    answer_q52 = models.IntegerField()
    start_time5 = models.FloatField()
    elapsed_time5 = models.FloatField()
    is_correct5 = models.BooleanField()
    count5 = models.IntegerField()
    score5 = models.DecimalField(max_digits=5, decimal_places=2)

    answer_q61 = models.IntegerField()
    answer_q62 = models.IntegerField()
    start_time6 = models.FloatField()
    elapsed_time6 = models.FloatField()
    is_correct6 = models.BooleanField()
    count6 = models.IntegerField()
    score6 = models.DecimalField(max_digits=5, decimal_places=2)

    answer_q71 = models.IntegerField()
    answer_q72 = models.IntegerField()
    start_time7 = models.FloatField()
    elapsed_time7 = models.FloatField()
    is_correct7 = models.BooleanField()
    count7 = models.IntegerField()
    score7 = models.DecimalField(max_digits=5, decimal_places=2)

    answer_q81 = models.IntegerField()
    answer_q82 = models.IntegerField()
    start_time8 = models.FloatField()
    elapsed_time8 = models.FloatField()
    is_correct8 = models.BooleanField()
    count8 = models.IntegerField()
    score8 = models.DecimalField(max_digits=5, decimal_places=2)

    answer_q91 = models.IntegerField()
    answer_q92 = models.IntegerField()
    start_time9 = models.FloatField()
    elapsed_time9 = models.FloatField()
    is_correct9 = models.BooleanField()
    count9 = models.IntegerField()
    score9 = models.DecimalField(max_digits=5, decimal_places=2)

    answer_q101 = models.IntegerField()
    answer_q102 = models.IntegerField()
    start_time10 = models.FloatField()
    elapsed_time10 = models.FloatField()
    is_correct10 = models.BooleanField()
    count10 = models.IntegerField()
    score10 = models.DecimalField(max_digits=5, decimal_places=2)

    matrix_payoff0 = models.CurrencyField()
    matrix_payoff = models.CurrencyField()
    avg_score = models.DecimalField(max_digits=5, decimal_places=1)

    def set_payoff0(self):
        self.matrix_payoff0 = max(round(90 - self.elapsed_time0, 2),0) / 60
        self.participant.vars['matrix_payoff0'] = self.matrix_payoff0


    def set_payoff(self):
        self.payoff = (max(round(90 - self.elapsed_time9, 2),0)) /60
        self.participant.vars['matrix_payoff'] = self.payoff

    def set_time9(self):
        self.participant.vars['t9'] = self.elapsed_time9

    def set_avg_score(self):
        self.avg_score = str(round((Decimal(self.participant.vars['score1']) +
                          Decimal(self.participant.vars['score2']) +
                          Decimal(self.participant.vars['score3']) +
                          Decimal(self.participant.vars['score4']) +
                          Decimal(self.participant.vars['score5']) +
                          Decimal(self.participant.vars['score6']) +
                          Decimal(self.participant.vars['score7']) +
                          Decimal(self.participant.vars['score8']) +
                          Decimal(self.participant.vars['score9']) +
                          Decimal(self.participant.vars['score10'])) * Decimal(repr(0.1)),2))
        self.participant.vars['avg_score'] = self.avg_score


    def check_correct0(self):
        newlist0 = (self.answer_q01, self.answer_q02)
        self.is_correct0 = any(x not in newlist0 for x in [Constants.solution_q01, Constants.solution_q02])


    def check_correct1(self):
        newlist1 = (self.answer_q11, self.answer_q12)
        self.is_correct1 = any(x not in newlist1 for x in [Constants.solution_q11, Constants.solution_q12])

    def check_correct2(self):
        newlist2 = (self.answer_q21, self.answer_q22)
        self.is_correct2 = any(x not in newlist2 for x in [Constants.solution_q21, Constants.solution_q22])

    def check_correct3(self):
        newlist3 = (self.answer_q31, self.answer_q32)
        self.is_correct3 = any(x not in newlist3 for x in [Constants.solution_q31, Constants.solution_q32])

    def check_correct4(self):
        newlist4 = (self.answer_q41, self.answer_q42)
        self.is_correct4 = any(x not in newlist4 for x in [Constants.solution_q41, Constants.solution_q42])

    def check_correct5(self):
        newlist5 = (self.answer_q51, self.answer_q52)
        self.is_correct5 = any(x not in newlist5 for x in [Constants.solution_q51, Constants.solution_q52])

    def check_correct6(self):
        newlist6 = (self.answer_q61, self.answer_q62)
        self.is_correct6 = any(x not in newlist6 for x in [Constants.solution_q61, Constants.solution_q62])

    def check_correct7(self):
        newlist7 = (self.answer_q71, self.answer_q72)
        self.is_correct7 = any(x not in newlist7 for x in [Constants.solution_q71, Constants.solution_q72])

    def check_correct8(self):
        newlist8 = (self.answer_q81, self.answer_q82)
        self.is_correct8 = any(x not in newlist8 for x in [Constants.solution_q81, Constants.solution_q82])

    def check_correct9(self):
        newlist9 = (self.answer_q91, self.answer_q92)
        self.is_correct9 = any(x not in newlist9 for x in [Constants.solution_q91, Constants.solution_q92])

    def check_correct10(self):
        newlist10 = (self.answer_q101, self.answer_q102)
        self.is_correct10 = any(x not in newlist10 for x in [Constants.solution_q101, Constants.solution_q102])

    # def set_matrix_payoff(self):
    #  self.matrix_payoff = (self.participant.vars['score5']) * (0.045)
    # self.participant.vars['matrix_payoff'] = self.player.matrix_payoff
