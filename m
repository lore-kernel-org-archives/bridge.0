Return-Path: <sfeldma@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=zNerctIB99Ws2ziUw1taF44gAXEcdN/m5RkbjznJOQA=;
	b=u2KqPr1VcBmG7Pl0r2CZ7IUsJtwnJoGAO6LvZbMXPkE5l2t5FVdumnLrMZ8GJFhwOk
	O0+AT2qVByAXCdC2wkzb2Nd5tc74V+Kk0ibs3dm45acFkECD+ZVgf7DTj+2+HUNDyOLe
	eKooNADYxmQj1WNJK2IvgBxWxMsxWbjcvH6E/G8dhwknEMHjMPzh7fTw+wN6sRYHzzsX
	ZtK/f2gtMz6wGQPLha5eqKI7E1ghDmXOUdWv6Aj/rmKzQc3oEL/neG7l3Jqi74dMXSRV
	rCace2OSePz24pPS2xEHaDhNNo+wcRnXFWu2iQvQJXmJDMJazcQjshOuju30r5M+lcx7
	F41A==
MIME-Version: 1.0
In-Reply-To: <CABQ03vEQhdXgWk5r103Yd0CPxEWuU3i0m8ztQjtgR0NFDbEXRQ@mail.gmail.com>
References: <1432204977-4293-1-git-send-email-nikolay@cumulusnetworks.com>
	<20150526102809.5c3e8abc@urahara>
	<CABQ03vEQhdXgWk5r103Yd0CPxEWuU3i0m8ztQjtgR0NFDbEXRQ@mail.gmail.com>
Date: Wed, 27 May 2015 00:59:15 -0700
Message-ID: <CAE4R7bBEn8Tvct_W0n7nR5YccEmTRByUc=-4nmvuQNqfrBFABg@mail.gmail.com>
From: Scott Feldman <sfeldma@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [PATCH net-next] bridge: skip fdb add if the port
	shouldn't learn
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>, Netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, Wilson Kok <wkok@cumulusnetworks.com>, David Miller <davem@davemloft.net>

On Wed, May 27, 2015 at 12:05 AM, Nikolay Aleksandrov
<nikolay@cumulusnetworks.com> wrote:
> On Tue, May 26, 2015 at 7:28 PM, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
>> On Thu, 21 May 2015 03:42:57 -0700
>> Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
>>
>>> From: Wilson Kok <wkok@cumulusnetworks.com>
>>>
>>> Check in fdb_add_entry() if the source port should learn, similar
>>> check is used in br_fdb_update.
>>> Note that new fdb entries which are added manually or
>>> as local ones are still permitted.
>>> This patch has been tested by running traffic via a bridge port and
>>> switching the port's state, also by manually adding/removing entries
>>> from the bridge's fdb.
>>>
>>> Signed-off-by: Wilson Kok <wkok@cumulusnetworks.com>
>>> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>>
>> What is the problem this is trying to solve?
>>
>> I think user should be allowed to manually add any entry
>> even if learning.
>
> Hi Stephen,
> I have been thinking about the use case and have discussed it
> internally with colleagues and the patch
> author, the main problem is when there's an external software that
> adds dynamic entries (learning) and
> it could experience a race condition, here's a possible situation:
> * external software learns a mac from hw, sends an add to kernel
>  * right before that, port goes blocking (or down) and kernel flushes
>    mac, sends notification about the state change and mac flush
>  * right after that, kernel gets the previous add from external software, it's
>    allowed to add, and then sends an add notification
>  * mean while, external software processes the link block/down and mac flush,
>    followed by the mac add from kernel.  At this point, external software can't
>    really know whether it's a user adding the mac intentionally or it's
>    a race.
>
> This issue can't really be avoided in user-space.
> As I've noted local and static entries are still allowed, and iproute2
> bridge utility always
> marks the entries as static (NUD_NOARP), this only affects external
> dynamic entries which
> are usually sent by something that does the learning externally.
> I'll keep digging to see if there's another way to go about this since
> I'd like to give the user
> full freedom. Personally I don't have strong feeling for this patch
> and if it's not preferred then
> I'll post a revert.

So there is already a switchdev API to add/del an externally learned
FDB entry which holds rtnl_lock and avoids these races.  I would
suggest using that and revert this patch.

See call_switchdev_notifiers(SWITCHDEV_FDB_ADD|SWITCHDEV_FDB_DEL) and
the handler in br.c:br_switchdev_event().

-scott
