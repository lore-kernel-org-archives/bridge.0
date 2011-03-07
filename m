Message-ID: <4D755364.1050100@gmail.com>
Date: Mon, 07 Mar 2011 22:51:32 +0100
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?=
 <nicolas.2p.debian@gmail.com>
MIME-Version: 1.0
References: <1649722795.14144.1299480074110.JavaMail.root@tahiti.vyatta.com>	<4D748CC3.8060603@gmail.com>	<20110307103406.27330529@nehalam>	<4D754490.4000105@gmail.com>
	<20110307134450.652aea32@nehalam>
In-Reply-To: <20110307134450.652aea32@nehalam>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] bridge: control carrier based on ports online
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Jay Vosburgh <fubar@us.ibm.com>, "Pekka Savola (ipv6)" <pekkas@netcore.fi>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, James Morris <jmorris@namei.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "David S. Miller" <davem@davemloft.net>, Adam Majer <adamm@zombino.com>

Le 07/03/2011 22:44, Stephen Hemminger a =E9crit :
> On Mon, 07 Mar 2011 21:48:16 +0100
> Nicolas de Peslo=FCan<nicolas.2p.debian@gmail.com>  wrote:
>
>> Le 07/03/2011 19:34, Stephen Hemminger a =E9crit :
[snip]
>>>    	list_for_each_entry(p,&br->port_list, list) {
>>> -		if (p->state !=3D BR_STATE_DISABLED) {
>>> -			if (p->port_no =3D=3D br->root_port) {
>>> -				p->config_pending =3D 0;
>>> -				p->topology_change_ack =3D 0;
>>> -				br_make_forwarding(p);
>>> -			} else if (br_is_designated_port(p)) {
>>> -				del_timer(&p->message_age_timer);
>>> -				br_make_forwarding(p);
>>> -			} else {
>>> -				p->config_pending =3D 0;
>>> -				p->topology_change_ack =3D 0;
>>> -				br_make_blocking(p);
>>> -			}
>>> +		if (p->state =3D=3D BR_STATE_DISABLED)
>>> +			continue;
>>> +
>>> +		if (p->port_no =3D=3D br->root_port) {
>>> +			p->config_pending =3D 0;
>>> +			p->topology_change_ack =3D 0;
>>> +			br_make_forwarding(p);
>>> +		} else if (br_is_designated_port(p)) {
>>> +			del_timer(&p->message_age_timer);
>>> +			br_make_forwarding(p);
>>> +		} else {
>>> +			p->config_pending =3D 0;
>>> +			p->topology_change_ack =3D 0;
>>> +			br_make_blocking(p);
>>
>> Is the above part really related to the purpose of this patch? It looks =
like (good) cleanup, but
>> should be in a different patch.
>>
>> Except from this comment,
>>
>> Reviewed-by: Nicolas de Peslo=FCan<nicolas.2p.debian@free.fr>
>
> The loop is going over the state of ports.
> Since the new code at the end of loop has to check for STATE_FORWARDING
> it is clearer with continue statement.  When adding code it is always
> better to clarify the logic in the process rather than making it
> more complex.

Sound's good to me. Thanks for clarifying.

	Nicolas.
