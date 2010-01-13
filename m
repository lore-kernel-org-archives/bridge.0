MIME-Version: 1.0
Date: Wed, 13 Jan 2010 11:29:55 +0100
Message-ID: <8cad0aa1001130229m18bff0b3mfd58c813c1b6a183@mail.gmail.com>
From: Jean-Michel Hautbois <jhautbois@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Re :Re: Re :Re: Bridging LACP (802.3ad) frames not
	working
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: bridge@lists.linux-foundation.org

2010/1/13 Stephen Hemminger <shemminger@vyatta.com>:
> On Tue, 12 Jan 2010 17:04:48 -0500
> Ross Vandegrift <ross@kallisti.us> wrote:
>
>> On Tue, Jan 12, 2010 at 09:40:30PM +0000, jhautbois@gmail.com wrote:
>> > This is exactly the problem.
>> > But, sounds like it is not possible... ?
>>
>> You could run a custom version of the bridge driver to enable bridging
>> of frames sent to the bridge-management MAC addresses. =A0Some folks
>> have talked about doing similar things to enable bridging of STP.
>>
>> Doing that with STP makes a bit more sense to me (since there are
>> valid networks that could be constructed that way). =A0But you'll be
>> breaking a pretty fundamental assumption of LACP....
>
> Recent kernels will forward link local frames as long as STP is disabled.
> Older kernels will not.
>
> The assumption is that if STP is enabled, then it will be managing
> control plane.

Well, I have a 2.6.31 kernel. And LACP is not forwarded, even when STP
is disabled.
I don't understand what you mean ?

JM
