MIME-Version: 1.0
In-Reply-To: <20090514083523.643b640b@nehalam>
References: <1242298904-31325-1-git-send-email-ian.campbell@citrix.com>
	<20090514083523.643b640b@nehalam>
Date: Fri, 15 May 2009 12:04:28 -0500
Message-ID: <2e59e6970905151004r547332abtae36104a885df407@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] BRIDGE: Do not suppress FDB learning after
	topology change when forward_delay is 0.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org, Ian Campbell <ian.campbell@citrix.com>

On Thu, May 14, 2009 at 10:35 AM, Stephen Hemminger
<shemminger@linux-foundation.org> wrote:
> On Thu, 14 May 2009 12:01:44 +0100
> Ian Campbell <ian.campbell@citrix.com> wrote:
>
>> I recently noticed that my bridges were flooding traffic for a period of=
 time
>> after a topology change. These bridges are part of a Xen host and theref=
ore
>> have spanning tree disabled and forward_delay of zero. In this situation=
 there
>> is no reason not to begin relearning immediately after a topology change=
.
>>
>> The existing code uses hold_time =3D=3D 0 to suppress learning in br_fdb=
_update.
>> hold_time() returns forward_delay if a topology change has recently occu=
rred
>> and ageing_time if not. Setting each of those to zero has slightly diffe=
rent
>> semantics: Setting forward_delay to zero effectively means forward immed=
iately
>> while setting ageing_time to zero effectively means do not learn.
>>
>> The solution is to not learn after a topology change only if forward_del=
ay is
>> non-zero but to retain the existing behaviour based on ageing_time if a
>> topology change has not occured.
>
>
> Unless STP is enabled, br_topology_change is bogus. =A0It looks like,
> the following would avoid the problem?
>
> --- a/net/bridge/br_stp.c =A0 =A0 =A0 2009-05-14 08:33:01.795909321 -0700
> +++ b/net/bridge/br_stp.c =A0 =A0 =A0 2009-05-14 08:34:32.839883992 -0700
> @@ -375,7 +375,8 @@ static void br_make_forwarding(struct ne
>
> =A0 =A0 =A0 =A0if (br->forward_delay =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p->state =3D BR_STATE_FORWARDING;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 br_topology_change_detection(br);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p->br->stp_enable =3D=3D BR_KERNEL_STP)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 br_topology_change_detectio=
n(br);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0del_timer(&p->forward_delay_timer);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0else if (p->br->stp_enabled =3D=3D BR_KERNEL_STP)

Comparing the new line to the last line of the snippet, it looks like
this change is wrong.  Are there really two members "stp_enable" and
"stp_enabled" of the same structure?

>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
