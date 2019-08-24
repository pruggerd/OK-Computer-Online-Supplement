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


author = 'Sarah'

doc = """
This a 5 demographic questionnaire
"""


class Constants(BaseConstants):
    name_in_url = 'Demographic'
    players_per_group = None
    num_rounds = 1


class Subsession(BaseSubsession):
    pass


class Group(BaseGroup):
    pass


class Player(BasePlayer):
    age = models.IntegerField(
        choices=[[1, 'less than 15'], [2, '15-20'], [3, ' 20-25'], [4, '25 - 30'], [5, '30 - 35'], [6, '35 - 40'],
                 [7, '40 - 45'], [8, '45 - 50'], [9, '50 - 55'], [10, '55 - 60'], [11, '60 - 65'], [12, '65 or higher']
                 ],
    )
    gender = models.IntegerField( choices=[[0, 'Female'],[1, 'Male']]
                                )

    nationality = models.StringField(
        choices=[['AF', 'Afghanistan'], ['AL', 'Albania'], ['DZ', 'Algeria'], ['AS', 'American Samoa'],
                 ['AD', 'Andorra'], ['AO', 'Angola'], ['AI', 'Anguilla'], ['AQ', 'Antarctica'],
                 ['AG', 'Antigua And Barbuda'], ['AR', 'Argentina'], ['AM', 'Armenia'], ['AW', 'Aruba'],
                 ['AU', 'Australia'], ['AT', 'Austria'], ['AZ', 'Azerbaijan'], ['BS', 'Bahamas'], ['BH', 'Bahrain'],
                 ['BD', 'Bangladesh'], ['BB', 'Barbados'], ['BY', 'Belarus'], ['BE', 'Belgium'], ['BZ', 'Belize'],
                 ['BJ', 'Benin'], ['BM', 'Bermuda'], ['BT', 'Bhutan'], ['BO', 'Bolivia'],
                 ['BA', 'Bosnia And Herzegowina'], ['BW', 'Botswana'], ['BV', 'Bouvet Island'], ['BR', 'Brazil'],
                 ['BN', 'Brunei Darussalam'], ['BG', 'Bulgaria'], ['BF', 'Burkina Faso'], ['BI', 'Burundi'],
                 ['KH', 'Cambodia'], ['CM', 'Cameroon'], ['CA', 'Canada'], ['CV', 'Cape Verde'],
                 ['KY', 'Cayman Islands'], ['CF', 'Central African Rep'], ['TD', 'Chad'], ['CL', 'Chile'],
                 ['CN', 'China'], ['CX', 'Christmas Island'], ['CC', 'Cocos Islands'], ['CO', 'Colombia'],
                 ['KM', 'Comoros'], ['CG', 'Congo'], ['CK', 'Cook Islands'], ['CR', 'Costa Rica'],
                 ['CI', 'Cote D`ivoire'], ['HR', 'Croatia'], ['CU', 'Cuba'], ['CY', 'Cyprus'], ['CZ', 'Czech Republic'],
                 ['DK', 'Denmark'], ['DJ', 'Djibouti'], ['DM', 'Dominica'], ['DO', 'Dominican Republic'],
                 ['TP', 'East Timor'], ['EC', 'Ecuador'], ['EG', 'Egypt'], ['SV', 'El Salvador'],
                 ['GQ', 'Equatorial Guinea'], ['ER', 'Eritrea'], ['EE', 'Estonia'], ['ET', 'Ethiopia'],
                 ['FK', 'Falkland Islands (Malvinas)'], ['FO', 'Faroe Islands'], ['FJ', 'Fiji'], ['FI', 'Finland'],
                 ['FR', 'France'], ['GF', 'French Guiana'], ['PF', 'French Polynesia'], ['TF', 'French S. Territories'],
                 ['GA', 'Gabon'], ['GM', 'Gambia'], ['GE', 'Georgia'], ['DE', 'Germany'], ['GH', 'Ghana'],
                 ['GI', 'Gibraltar'], ['GR', 'Greece'], ['GL', 'Greenland'], ['GD', 'Grenada'], ['GP', 'Guadeloupe'],
                 ['GU', 'Guam'], ['GT', 'Guatemala'], ['GN', 'Guinea'], ['GW', 'Guinea-bissau'], ['GY', 'Guyana'],
                 ['HT', 'Haiti'], ['HN', 'Honduras'], ['HK', 'Hong Kong'], ['HU', 'Hungary'], ['IS', 'Iceland'],
                 ['IN', 'India'], ['ID', 'Indonesia'], ['IR', 'Iran'], ['IQ', 'Iraq'], ['IE', 'Ireland'],
                 ['IL', 'Israel'], ['IT', 'Italy'], ['JM', 'Jamaica'], ['JP', 'Japan'], ['JO', 'Jordan'],
                 ['KZ', 'Kazakhstan'], ['KE', 'Kenya'], ['KI', 'Kiribati'], ['KP', 'Korea (North)'],
                 ['KR', 'Korea (South)'], ['KS', 'Kosovo'], ['KW', 'Kuwait'], ['KG', 'Kyrgyzstan'], ['LA', 'Laos'], ['LV', 'Latvia'],
                 ['LB', 'Lebanon'], ['LS', 'Lesotho'], ['LR', 'Liberia'], ['LY', 'Libya'], ['LI', 'Liechtenstein'],
                 ['LT', 'Lithuania'], ['LU', 'Luxembourg'], ['MO', 'Macau'], ['MK', 'Macedonia'], ['MG', 'Madagascar'],
                 ['MW', 'Malawi'], ['MY', 'Malaysia'], ['MV', 'Maldives'], ['ML', 'Mali'], ['MT', 'Malta'],
                 ['MH', 'Marshall Islands'], ['MQ', 'Martinique'], ['MR', 'Mauritania'], ['MU', 'Mauritius'],
                 ['YT', 'Mayotte'], ['MX', 'Mexico'], ['FM', 'Micronesia'], ['MD', 'Moldova'], ['MC', 'Monaco'],
                 ['MN', 'Mongolia'], ['ME', 'Montenegro'], ['MS', 'Montserrat'], ['MA', 'Morocco'], ['MZ', 'Mozambique'], ['MM', 'Myanmar'],
                 ['NA', 'Namibia'], ['NR', 'Nauru'], ['NP', 'Nepal'], ['NL', 'Netherlands'],
                 ['AN', 'Netherlands Antilles'], ['NC', 'New Caledonia'], ['NZ', 'New Zealand'], ['NI', 'Nicaragua'],
                 ['NE', 'Niger'], ['NG', 'Nigeria'], ['NU', 'Niue'], ['NF', 'Norfolk Island'],
                 ['MP', 'Northern Mariana Islands'], ['NO', 'Norway'], ['OM', 'Oman'], ['PK', 'Pakistan'],
                 ['PW', 'Palau'], ['PA', 'Panama'], ['PG', 'Papua New Guinea'], ['PY', 'Paraguay'], ['PE', 'Peru'],
                 ['PH', 'Philippines'], ['PN', 'Pitcairn'], ['PL', 'Poland'], ['PT', 'Portugal'], ['PR', 'Puerto Rico'],
                 ['QA', 'Qatar'], ['RE', 'Reunion'], ['RO', 'Romania'], ['RU', 'Russian Federation'], ['RW', 'Rwanda'],
                 ['KN', 'Saint Kitts And Nevis'], ['LC', 'Saint Lucia'], ['VC', 'St Vincent/Grenadines'],
                 ['WS', 'Samoa'], ['SM', 'San Marino'], ['ST', 'Sao Tome'], ['SA', 'Saudi Arabia'], ['SN', 'Senegal'],
                 ['EB', 'Serbia'],['SC', 'Seychelles'], ['SL', 'Sierra Leone'], ['SG', 'Singapore'], ['SK', 'Slovakia'],
                 ['SI', 'Slovenia'], ['SB', 'Solomon Islands'], ['SO', 'Somalia'], ['ZA', 'South Africa'],
                 ['ES', 'Spain'], ['LK', 'Sri Lanka'], ['SH', 'St. Helena'], ['PM', 'St.Pierre'], ['SD', 'Sudan'],
                 ['SR', 'Suriname'], ['SZ', 'Swaziland'], ['SE', 'Sweden'], ['CH', 'Switzerland'],
                 ['SY', 'Syrian Arab Republic'], ['TW', 'Taiwan'], ['TJ', 'Tajikistan'], ['TZ', 'Tanzania'],
                 ['TH', 'Thailand'], ['TG', 'Togo'], ['TK', 'Tokelau'], ['TO', 'Tonga'], ['TT', 'Trinidad And Tobago'],
                 ['TN', 'Tunisia'], ['TR', 'Turkey'], ['TM', 'Turkmenistan'], ['TV', 'Tuvalu'], ['UG', 'Uganda'],
                 ['UA', 'Ukraine'], ['AE', 'United Arab Emirates'], ['UK', 'United Kingdom'], ['US', 'United States'],
                 ['UY', 'Uruguay'], ['UZ', 'Uzbekistan'], ['VU', 'Vanuatu'], ['VA', 'Vatican City State'],
                 ['VE', 'Venezuela'], ['VN', 'Viet Nam'], ['VG', 'Virgin Islands (British)'],
                 ['VI', 'Virgin Islands (U.S.)'], ['EH', 'Western Sahara'], ['YE', 'Yemen'],
                 ['ZR', 'Zaire'], ['ZM', 'Zambia'], ['ZW', 'Zimbabwe']
                 ])
    residency = models.StringField(
        choices=[['AF', 'Afghanistan'], ['AL', 'Albania'], ['DZ', 'Algeria'], ['AS', 'American Samoa'],
                 ['AD', 'Andorra'], ['AO', 'Angola'], ['AI', 'Anguilla'], ['AQ', 'Antarctica'],
                 ['AG', 'Antigua And Barbuda'], ['AR', 'Argentina'], ['AM', 'Armenia'], ['AW', 'Aruba'],
                 ['AU', 'Australia'], ['AT', 'Austria'], ['AZ', 'Azerbaijan'], ['BS', 'Bahamas'], ['BH', 'Bahrain'],
                 ['BD', 'Bangladesh'], ['BB', 'Barbados'], ['BY', 'Belarus'], ['BE', 'Belgium'], ['BZ', 'Belize'],
                 ['BJ', 'Benin'], ['BM', 'Bermuda'], ['BT', 'Bhutan'], ['BO', 'Bolivia'],
                 ['BA', 'Bosnia And Herzegowina'], ['BW', 'Botswana'], ['BV', 'Bouvet Island'], ['BR', 'Brazil'],
                 ['BN', 'Brunei Darussalam'], ['BG', 'Bulgaria'], ['BF', 'Burkina Faso'], ['BI', 'Burundi'],
                 ['KH', 'Cambodia'], ['CM', 'Cameroon'], ['CA', 'Canada'], ['CV', 'Cape Verde'],
                 ['KY', 'Cayman Islands'], ['CF', 'Central African Rep'], ['TD', 'Chad'], ['CL', 'Chile'],
                 ['CN', 'China'], ['CX', 'Christmas Island'], ['CC', 'Cocos Islands'], ['CO', 'Colombia'],
                 ['KM', 'Comoros'], ['CG', 'Congo'], ['CK', 'Cook Islands'], ['CR', 'Costa Rica'],
                 ['CI', 'Cote D`ivoire'], ['HR', 'Croatia'], ['CU', 'Cuba'], ['CY', 'Cyprus'], ['CZ', 'Czech Republic'],
                 ['DK', 'Denmark'], ['DJ', 'Djibouti'], ['DM', 'Dominica'], ['DO', 'Dominican Republic'],
                 ['TP', 'East Timor'], ['EC', 'Ecuador'], ['EG', 'Egypt'], ['SV', 'El Salvador'],
                 ['GQ', 'Equatorial Guinea'], ['ER', 'Eritrea'], ['EE', 'Estonia'], ['ET', 'Ethiopia'],
                 ['FK', 'Falkland Islands (Malvinas)'], ['FO', 'Faroe Islands'], ['FJ', 'Fiji'], ['FI', 'Finland'],
                 ['FR', 'France'], ['GF', 'French Guiana'], ['PF', 'French Polynesia'], ['TF', 'French S. Territories'],
                 ['GA', 'Gabon'], ['GM', 'Gambia'], ['GE', 'Georgia'], ['DE', 'Germany'], ['GH', 'Ghana'],
                 ['GI', 'Gibraltar'], ['GR', 'Greece'], ['GL', 'Greenland'], ['GD', 'Grenada'], ['GP', 'Guadeloupe'],
                 ['GU', 'Guam'], ['GT', 'Guatemala'], ['GN', 'Guinea'], ['GW', 'Guinea-bissau'], ['GY', 'Guyana'],
                 ['HT', 'Haiti'], ['HN', 'Honduras'], ['HK', 'Hong Kong'], ['HU', 'Hungary'], ['IS', 'Iceland'],
                 ['IN', 'India'], ['ID', 'Indonesia'], ['IR', 'Iran'], ['IQ', 'Iraq'], ['IE', 'Ireland'],
                 ['IL', 'Israel'], ['IT', 'Italy'], ['JM', 'Jamaica'], ['JP', 'Japan'], ['JO', 'Jordan'],
                 ['KZ', 'Kazakhstan'], ['KE', 'Kenya'], ['KI', 'Kiribati'], ['KP', 'Korea (North)'],
                 ['KR', 'Korea (South)'], ['KS', 'Kosovo'], ['KW', 'Kuwait'], ['KG', 'Kyrgyzstan'], ['LA', 'Laos'], ['LV', 'Latvia'],
                 ['LB', 'Lebanon'], ['LS', 'Lesotho'], ['LR', 'Liberia'], ['LY', 'Libya'], ['LI', 'Liechtenstein'],
                 ['LT', 'Lithuania'], ['LU', 'Luxembourg'], ['MO', 'Macau'], ['MK', 'Macedonia'], ['MG', 'Madagascar'],
                 ['MW', 'Malawi'], ['MY', 'Malaysia'], ['MV', 'Maldives'], ['ML', 'Mali'], ['MT', 'Malta'],
                 ['MH', 'Marshall Islands'], ['MQ', 'Martinique'], ['MR', 'Mauritania'], ['MU', 'Mauritius'],
                 ['YT', 'Mayotte'], ['MX', 'Mexico'], ['FM', 'Micronesia'], ['MD', 'Moldova'], ['MC', 'Monaco'],
                 ['MN', 'Mongolia'], ['ME', 'Montenegro'], ['MS', 'Montserrat'], ['MA', 'Morocco'], ['MZ', 'Mozambique'], ['MM', 'Myanmar'],
                 ['NA', 'Namibia'], ['NR', 'Nauru'], ['NP', 'Nepal'], ['NL', 'Netherlands'],
                 ['AN', 'Netherlands Antilles'], ['NC', 'New Caledonia'], ['NZ', 'New Zealand'], ['NI', 'Nicaragua'],
                 ['NE', 'Niger'], ['NG', 'Nigeria'], ['NU', 'Niue'], ['NF', 'Norfolk Island'],
                 ['MP', 'Northern Mariana Islands'], ['NO', 'Norway'], ['OM', 'Oman'], ['PK', 'Pakistan'],
                 ['PW', 'Palau'], ['PA', 'Panama'], ['PG', 'Papua New Guinea'], ['PY', 'Paraguay'], ['PE', 'Peru'],
                 ['PH', 'Philippines'], ['PN', 'Pitcairn'], ['PL', 'Poland'], ['PT', 'Portugal'], ['PR', 'Puerto Rico'],
                 ['QA', 'Qatar'], ['RE', 'Reunion'], ['RO', 'Romania'], ['RU', 'Russian Federation'], ['RW', 'Rwanda'],
                 ['KN', 'Saint Kitts And Nevis'], ['LC', 'Saint Lucia'], ['VC', 'St Vincent/Grenadines'],
                 ['WS', 'Samoa'], ['SM', 'San Marino'], ['ST', 'Sao Tome'], ['SA', 'Saudi Arabia'], ['SN', 'Senegal'],
                 ['EB', 'Serbia'], ['SC', 'Seychelles'], ['SL', 'Sierra Leone'], ['SG', 'Singapore'], ['SK', 'Slovakia'],
                 ['SI', 'Slovenia'], ['SB', 'Solomon Islands'], ['SO', 'Somalia'], ['ZA', 'South Africa'],
                 ['ES', 'Spain'], ['LK', 'Sri Lanka'], ['SH', 'St. Helena'], ['PM', 'St.Pierre'], ['SD', 'Sudan'],
                 ['SR', 'Suriname'], ['SZ', 'Swaziland'], ['SE', 'Sweden'], ['CH', 'Switzerland'],
                 ['SY', 'Syrian Arab Republic'], ['TW', 'Taiwan'], ['TJ', 'Tajikistan'], ['TZ', 'Tanzania'],
                 ['TH', 'Thailand'], ['TG', 'Togo'], ['TK', 'Tokelau'], ['TO', 'Tonga'], ['TT', 'Trinidad And Tobago'],
                 ['TN', 'Tunisia'], ['TR', 'Turkey'], ['TM', 'Turkmenistan'], ['TV', 'Tuvalu'], ['UG', 'Uganda'],
                 ['UA', 'Ukraine'], ['AE', 'United Arab Emirates'], ['UK', 'United Kingdom'], ['US', 'United States'],
                 ['UY', 'Uruguay'], ['UZ', 'Uzbekistan'], ['VU', 'Vanuatu'], ['VA', 'Vatican City State'],
                 ['VE', 'Venezuela'], ['VN', 'Viet Nam'], ['VG', 'Virgin Islands (British)'],
                 ['VI', 'Virgin Islands (U.S.)'], ['EH', 'Western Sahara'], ['YE', 'Yemen'],
                 ['ZR', 'Zaire'], ['ZM', 'Zambia'], ['ZW', 'Zimbabwe']
                 ])
    ethnicity = models.StringField(
        choices=[['White', 'White'], ['Hispanic', 'Hispanic or Latino'], ['Black', 'Black or African American'],
                 ['Asian', 'Asian'], ['Indian American', 'American Indian or Alaska native'],
                 ['Middle Easter', 'Middle Easter or North African'],
                 ['Pacific Islander', 'Native Hawaiian or other Pacific Islander'],
                 ['Other', 'Some other race or ethnicity'],
                 ]
    )
    education = models.IntegerField(
        choices=[
            [1, 'some secondary education (high school)'],
            [2, 'completed secondary education (graduated high school)'],
            [3, 'trade/technical/vocational training'],
            [4, 'some undergraduate education (college or university)'],
            [5, 'completed undergraduate education'],
            [6, 'some postgraduate education'],
            [7, 'completed postgraduate education (masters or doctorate)'],

        ])

    def set_participant(self):
        self.participant.vars['age'] = self.age
        self.participant.vars['gender'] = self.gender
        self.participant.vars['education'] = self.education
        if self.ethnicity == 'White':
            self.participant.vars['ethnicity'] = 1

        else:
            self.participant.vars['ethnicity'] = 0

    def set_time9(self):
        self.participant.vars['t9'] = self.elapsed_time9

