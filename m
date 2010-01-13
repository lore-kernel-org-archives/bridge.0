MIME-Version: 1.0
In-Reply-To: <2e59e6971001121458s497910bdx90c1c05aab076a08@mail.gmail.com>
References: <2e59e6971001121458s497910bdx90c1c05aab076a08@mail.gmail.com>
Date: Wed, 13 Jan 2010 10:26:54 +0100
Message-ID: <8cad0aa1001130126n4170061dxb4152fd232cf7325@mail.gmail.com>
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
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: bridge@lists.linux-foundation.org

2010/1/12 richardvoigt@gmail.com <richardvoigt@gmail.com>:
> On Tue, Jan 12, 2010 at 4:04 PM, Ross Vandegrift <ross@kallisti.us> wrote=
:
>> On Tue, Jan 12, 2010 at 09:40:30PM +0000, jhautbois@gmail.com wrote:
>>> This is exactly the problem.
>>> But, sounds like it is not possible... ?
>>
>> You could run a custom version of the bridge driver to enable bridging
>> of frames sent to the bridge-management MAC addresses. =A0Some folks
>> have talked about doing similar things to enable bridging of STP.
>>
>> Doing that with STP makes a bit more sense to me (since there are
>> valid networks that could be constructed that way). =A0But you'll be
>> breaking a pretty fundamental assumption of LACP....
>
> LACP is between peers, not to the nearest connected device (generally
> an ethernet cable). =A0As long as the intermediate link acts just like a
> wire and passes everything, LACP shouldn't care. =A0And there are some
> reasonable cases to want a Linux box to look like a piece of cable
> (e.g. wiretap, timed lockdown, satellite network simulator which
> inserts delay and errors, etc.) to the surrounding network. =A0Of
> course, whether seeing just one link out of an aggregation bundle is
> useful is debatable, but Linux ought to be able to support it. =A0I've
> been bitten before by adding a new switch into an STP setup and having
> it eat STP packets even though STP processing was disabled. =A0So count
> me as another vote for (at least the possibility of) layer 1-esque
> transparent bridging.

I think it would be interesting to have the ability to activate this
functionality.
AFAIK, this could be done in the br_handle_frame function, testing the
skb->protocol and comparing it with ETH_P_SLOW. This could be
conditionned by a flag, and this flag would be unabled by default.

Why is this a problem ?
If you tell this is not good, unless you know what you are doing,
where is the problem ?
This is a user problem, it is a functionality. If you misuse it, this
is not a kernel problem...

Best Regards,
JM
