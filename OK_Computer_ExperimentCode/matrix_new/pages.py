from otree.api import Currency as c, currency_range
from ._builtin import Page, WaitPage
from .models import Constants
# from decimal import Decimal
import time


class Start(Page):

    def is_displayed(self):
        return self.round_number == 1

    def before_next_page(self):
        self.player.start_time1 = time.time()
        self.player.count1 = 1
        self.player.start_time0 = time.time()
        self.player.count0 = 1


class training(Page):
    timeout_seconds = 90
    form_model = 'player'
    form_fields = ['answer_q01', 'answer_q02']

    def error_message(self, values):
        newlist = (values['answer_q01'], values['answer_q02'])
        if any(x not in newlist for x in [Constants.solution_q01, Constants.solution_q02]):
            self.player.count0 = self.player.count0 + 1
            return 'Your answer is NOT correct! Please try again'


    def before_next_page(self):
        self.player.check_correct0()
        self.player.elapsed_time0 = round(time.time() - self.player.start_time0, 2)
        self.player.set_payoff0()


class training2(Page):
    def vars_for_template(self):
        self.participant.vars['score0'] = max(round(90 - self.player.elapsed_time0, 2),0)
        return {
            'score0': self.participant.vars['score0'],
            'time0': self.player.elapsed_time0,
            'count0': self.player.count0,
            'matrix_payoff0': self.player.matrix_payoff0,
        }

class training3(Page):
    def before_next_page(self):
        self.player.start_time1 = time.time()
        self.player.count1 = 1




class q1(Page):
    timeout_seconds = 90
    form_model = 'player'
    form_fields = ['answer_q11', 'answer_q12']

    def error_message(self, values):
        newlist = (values['answer_q11'], values['answer_q12'])
        if any(x not in newlist for x in [Constants.solution_q11, Constants.solution_q12]):
            self.player.count1 = self.player.count1 + 1
            return 'Your answer is NOT correct! Please try again'

    def before_next_page(self):
        self.player.check_correct1()
        self.player.elapsed_time1 = round(time.time() - self.player.start_time1, 2)
        self.player.start_time2 = time.time()
        self.player.count2 = 1


class q2(Page):
    timeout_seconds = 90
    form_model = 'player'
    form_fields = ['answer_q21', 'answer_q22']

    def error_message(self, values):
        newlist = (values['answer_q21'], values['answer_q22'])
        if any(x not in newlist for x in [Constants.solution_q21, Constants.solution_q22]):
            self.player.count2 = self.player.count2 + 1
            return 'Your answer is NOT correct! Please try again'

    def before_next_page(self):
        self.player.check_correct2()
        self.player.elapsed_time2 = round(time.time() - self.player.start_time2, 2)
        self.player.start_time3 = time.time()
        self.player.count3 = 1


class q3(Page):
    timeout_seconds = 90
    form_model = 'player'
    form_fields = ['answer_q31', 'answer_q32']

    def error_message(self, values):
        newlist = (values['answer_q31'], values['answer_q32'])
        if any(x not in newlist for x in [Constants.solution_q31, Constants.solution_q32]):
            self.player.count3 = self.player.count3 + 1
            return 'Your answer is NOT correct! Please try again'

    def before_next_page(self):
        self.player.check_correct3()
        self.player.elapsed_time3 = round(time.time() - self.player.start_time3, 2)
        self.player.start_time4 = time.time()
        self.player.count4 = 1


class q4(Page):
    timeout_seconds = 90
    form_model = 'player'
    form_fields = ['answer_q41', 'answer_q42']

    def error_message(self, values):
        newlist = (values['answer_q41'], values['answer_q42'])
        if any(x not in newlist for x in [Constants.solution_q41, Constants.solution_q42]):
            self.player.count4 = self.player.count4 + 1
            return 'Your answer is NOT correct! Please try again'

    def before_next_page(self):
        self.player.check_correct4()
        self.player.elapsed_time4 = round(time.time() - self.player.start_time4, 2)
        self.player.start_time5 = time.time()
        self.player.count5 = 1


class q5(Page):
    timeout_seconds = 90
    form_model = 'player'
    form_fields = ['answer_q51', 'answer_q52']

    def error_message(self, values):
        newlist = (values['answer_q51'], values['answer_q52'])
        if any(x not in newlist for x in [Constants.solution_q51, Constants.solution_q52]):
            self.player.count5 = self.player.count5 + 1
            return 'Your answer is NOT correct! Please try again'

    def before_next_page(self):
        self.player.check_correct5()
        self.player.elapsed_time5 = round(time.time() - self.player.start_time5, 2)
        self.player.start_time6 = time.time()
        self.player.count6 = 1


class q6(Page):
    timeout_seconds = 90
    form_model = 'player'
    form_fields = ['answer_q61', 'answer_q62']

    def error_message(self, values):
        newlist = (values['answer_q61'], values['answer_q62'])
        if any(x not in newlist for x in [Constants.solution_q61, Constants.solution_q62]):
            self.player.count6 = self.player.count6 + 1
            return 'Your answer is NOT correct! Please try again'

    def before_next_page(self):
        self.player.check_correct6()
        self.player.elapsed_time6 = round(time.time() - self.player.start_time6, 2)
        self.player.start_time7 = time.time()
        self.player.count7 = 1


class q7(Page):
    timeout_seconds = 90
    form_model = 'player'
    form_fields = ['answer_q71', 'answer_q72']

    def error_message(self, values):
        newlist = (values['answer_q71'], values['answer_q72'])
        if any(x not in newlist for x in [Constants.solution_q71, Constants.solution_q72]):
            self.player.count7 = self.player.count7 + 1
            return 'Your answer is NOT correct! Please try again'

    def before_next_page(self):
        self.player.check_correct7()
        self.player.elapsed_time7 = round(time.time() - self.player.start_time7, 2)
        self.player.start_time8 = time.time()
        self.player.count8 = 1


class q8(Page):
    timeout_seconds = 90
    form_model = 'player'
    form_fields = ['answer_q81', 'answer_q82']

    def error_message(self, values):
        newlist = (values['answer_q81'], values['answer_q82'])
        if any(x not in newlist for x in [Constants.solution_q81, Constants.solution_q82]):
            self.player.count8 = self.player.count8 + 1
            return 'Your answer is NOT correct! Please try again'

    def before_next_page(self):
        self.player.check_correct8()
        self.player.elapsed_time8 = round(time.time() - self.player.start_time8, 2)
        self.player.start_time9 = time.time()
        self.player.count9 = 1


class q9(Page):
    timeout_seconds = 90
    form_model = 'player'
    form_fields = ['answer_q91', 'answer_q92']

    def error_message(self, values):
        newlist = (values['answer_q91'], values['answer_q92'])
        if any(x not in newlist for x in [Constants.solution_q91, Constants.solution_q92]):
            self.player.count9 = self.player.count9 + 1
            return 'Your answer is NOT correct! Please try again'

    def before_next_page(self):
        self.player.check_correct9()
        self.player.elapsed_time9 = round(time.time() - self.player.start_time9, 2)
        self.player.start_time10 = time.time()
        self.player.count10 = 1


class q10(Page):
    timeout_seconds = 90
    form_model = 'player'
    form_fields = ['answer_q101', 'answer_q102']

    def error_message(self, values):
        newlist = (values['answer_q101'], values['answer_q102'])
        if any(x not in newlist for x in [Constants.solution_q101, Constants.solution_q102]):
            self.player.count10 = self.player.count10 + 1
            return 'Your answer is NOT correct! Please try again'

    def before_next_page(self):
        self.player.check_correct10()
        self.player.elapsed_time10 = round(time.time() - self.player.start_time10, 2)
        self.player.set_payoff()
        self.player.set_time9()



class Results(Page):
    def vars_for_template(self):
        self.participant.vars['score1'] = max(round(90 - self.player.elapsed_time1, 2),0)
        self.participant.vars['score2'] = max(round(90 - self.player.elapsed_time2, 2),0)
        self.participant.vars['score3'] = max(round(90 - self.player.elapsed_time3, 2),0)
        self.participant.vars['score4'] = max(round(90 - self.player.elapsed_time4, 2),0)
        self.participant.vars['score5'] = max(round(90 - self.player.elapsed_time5, 0),0)
        self.participant.vars['score6'] = max(round(90 - self.player.elapsed_time6, 2),0)
        self.participant.vars['score7'] = max(round(90 - self.player.elapsed_time7, 2),0)
        self.participant.vars['score8'] = max(round(90 - self.player.elapsed_time8, 2),0)
        self.participant.vars['score9'] = max(round(90 - self.player.elapsed_time9, 2),0)
        self.participant.vars['score10'] = max(round(90 - self.player.elapsed_time10, 2),0)

        return {
            'score1': self.participant.vars['score1'],
            'time1': self.player.elapsed_time1,
            'count1': self.player.count1,
            'score2': self.participant.vars['score2'],
            'count2': self.player.count2,
            'time2': self.player.elapsed_time2,
            'score3': self.participant.vars['score3'],
            'count3': self.player.count3,
            'time3': self.player.elapsed_time3,
            'score4': self.participant.vars['score4'],
            'count4': self.player.count4,
            'time4': self.player.elapsed_time4,
            'score5': self.participant.vars['score5'],
            'count5': self.player.count5,
            'time5': self.player.elapsed_time5,
            'score6': self.participant.vars['score6'],
            'count6': self.player.count6,
            'time6': self.player.elapsed_time6,
            'score7': self.participant.vars['score7'],
            'count7': self.player.count7,
            'time7': self.player.elapsed_time7,
            'score8': self.participant.vars['score8'],
            'count8': self.player.count8,
            'time8': self.player.elapsed_time8,
            'score9': self.participant.vars['score9'],
            'count9': self.player.count9,
            'time9': self.player.elapsed_time9,
            'score10': self.participant.vars['score10'],
            'count10': self.player.count10,
            'time10': self.player.elapsed_time10,
        }

    def before_next_page(self):
        self.player.set_payoff()
        self.player.set_avg_score()
        self.participant.vars['avg_score'] = self.player.avg_score
        self.player.set_time9()


class Payoff(Page):

    def vars_for_template(self):
        self.participant.vars['score1'] = max(round(90 - self.player.elapsed_time1, 3),0)
        self.participant.vars['score2'] = max(round(90 - self.player.elapsed_time2, 3),0)
        self.participant.vars['score3'] = max(round(90 - self.player.elapsed_time3, 3),0)
        self.participant.vars['score4'] = max(round(90 - self.player.elapsed_time4, 3),0)
        self.participant.vars['score5'] = max(round(90 - self.player.elapsed_time5, 3),0)
        self.participant.vars['score6'] = max(round(90 - self.player.elapsed_time6, 3),0)
        self.participant.vars['score7'] = max(round(90 - self.player.elapsed_time7, 3),0)
        self.participant.vars['score8'] = max(round(90 - self.player.elapsed_time8, 3),0)
        self.participant.vars['score9'] = max(round(90 - self.player.elapsed_time9, 3),0)
        self.participant.vars['score10'] = max(round(90 - self.player.elapsed_time10, 3),0)
        return {
            'score1': self.participant.vars['score1'],
            'time1': self.player.elapsed_time1,
            'count1': self.player.count1,
            'score2': self.participant.vars['score2'],
            'count2': self.player.count2,
            'time2': self.player.elapsed_time2,
            'score3': self.participant.vars['score3'],
            'count3': self.player.count3,
            'time3': self.player.elapsed_time3,
            'score4': self.participant.vars['score4'],
            'count4': self.player.count4,
            'time4': self.player.elapsed_time4,
            'score5': self.participant.vars['score5'],
            'count5': self.player.count5,
            'time5': self.player.elapsed_time5,
            'score6': self.participant.vars['score6'],
            'count6': self.player.count6,
            'time6': self.player.elapsed_time6,
            'score7': self.participant.vars['score7'],
            'count7': self.player.count7,
            'time7': self.player.elapsed_time7,
            'score8': self.participant.vars['score8'],
            'count8': self.player.count8,
            'time8': self.player.elapsed_time8,
            'score9': self.participant.vars['score9'],
            'count9': self.player.count9,
            'time9': self.player.elapsed_time9,
            'score10': self.participant.vars['score10'],
            'count10': self.player.count10,
            'time10': self.player.elapsed_time10,
            'matrix_payoff': self.player.payoff,
            'avg_score': self.participant.vars['avg_score'],
        }




class Payoff2(Page):

    def vars_for_template(self):
        return {
            'time9': self.player.elapsed_time9,
            'matrix_payoff': self.player.payoff,
        }




page_sequence = [
    Start,
    training,
    training2,
    training3,
    q1,
    q2,
    q3,
    q4,
    q5,
    q6,
    q7,
    q8,
    q9,
    q10,
    Results,
    Payoff2,

]
