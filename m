MIME-Version: 1.0
In-Reply-To: <20100120095453.09546783@nehalam>
References: <20100119214451.72637a94rn0biysz@mx.kpi.ua>
	<4B572FCA.8080905@kpi.ua> <20100120095453.09546783@nehalam>
Date: Wed, 20 Jan 2010 19:14:48 +0100
Message-ID: <8cad0aa1001201014ga54cf4br7b77577e874b4472@mail.gmail.com>
From: Jean-Michel Hautbois <jhautbois@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Re :Re: Re :Re: Re :Re: Bridging LACP (802.3ad) frames
	not working
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

2010/1/20 Stephen Hemminger <shemminger@linux-foundation.org>:
> On Wed, 20 Jan 2010 18:31:06 +0200
> Yavetskiy Yuriy <yavetskiy@kpi.ua> wrote:
>
>> Hello.
>>
>> I solve my problem without ebtables.
>> Just add to net/bridge/br_input.c next strings (with +):
>>
>> =A0 =A0 =A0 =A0 if (unlikely(is_link_local(dest))) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Pause frames shouldn't be passed up b=
y driver anyway */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (skb->protocol =3D=3D htons(ETH_P_PAU=
SE))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto drop;
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Don't touch SLOW frames (LACP, etc.)=
 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (skb->protocol =3D=3D htons(ETH_P_SLOW)=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto forward;
>>
>
> Fine for your case, but in general it is wrong to forward these
> frames.

I agree, and once again, I wish we could add a flag that enables
forwarding these frames.
A flag that would be off by default.
I don't understand why this could be problematic...

Regards,
JM
