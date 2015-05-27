Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=UQGxfJTw4vzUzukNiWU7s5LrKRm77mZP4oQS1zlA+Cg=;
	b=ORTILIhtSrlygmZOMvOwh+o9rDFoD2O1PITP9nhNvYEErflD3NU9RXchD+vOXzbeeT
	z1GpPG3KsR263zDAtnMuongyw29v4sKMT6vpj2y+drz7AUisDwUW5Ik8uoLZd+J6jNIR
	8DNZ4zT/9c4whHiGTEn5REgVMHfwveGw1mhbY=
MIME-Version: 1.0
In-Reply-To: <CAE4R7bDtY1jDcLnvEMx-y4U=SVvf867SPZc3vRjfrUYBA8W=0g@mail.gmail.com>
References: <1432204977-4293-1-git-send-email-nikolay@cumulusnetworks.com>
	<20150526102809.5c3e8abc@urahara>
	<CABQ03vEQhdXgWk5r103Yd0CPxEWuU3i0m8ztQjtgR0NFDbEXRQ@mail.gmail.com>
	<CAE4R7bBEn8Tvct_W0n7nR5YccEmTRByUc=-4nmvuQNqfrBFABg@mail.gmail.com>
	<CABQ03vEbgtHLyFmRs7ffpXGkTmjX9G=RbAhWwDrj-5rKysys5g@mail.gmail.com>
	<CAE4R7bDtY1jDcLnvEMx-y4U=SVvf867SPZc3vRjfrUYBA8W=0g@mail.gmail.com>
Date: Wed, 27 May 2015 18:14:47 +0200
Message-ID: <CABQ03vE_UqSpXdw7_nxFDt+aDgqW=XMnZrr4v72bqGJO6GUnpw@mail.gmail.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
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
To: Scott Feldman <sfeldma@gmail.com>
Cc: =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>, Netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, Wilson Kok <wkok@cumulusnetworks.com>, David Miller <davem@davemloft.net>

On Wed, May 27, 2015 at 6:01 PM, Scott Feldman <sfeldma@gmail.com> wrote:
> On Wed, May 27, 2015 at 1:35 AM, Nikolay Aleksandrov
> <nikolay@cumulusnetworks.com> wrote:
>> On Wed, May 27, 2015 at 9:59 AM, Scott Feldman <sfeldma@gmail.com> wrote:
>>> On Wed, May 27, 2015 at 12:05 AM, Nikolay Aleksandrov
>>> <nikolay@cumulusnetworks.com> wrote:
>>>> On Tue, May 26, 2015 at 7:28 PM, Stephen Hemminger
>>>> <stephen@networkplumber.org> wrote:
>>>>> On Thu, 21 May 2015 03:42:57 -0700
>>>>> Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
>>>>>
>>>>>> From: Wilson Kok <wkok@cumulusnetworks.com>
>>>>>>
>>>>>> Check in fdb_add_entry() if the source port should learn, similar
>>>>>> check is used in br_fdb_update.
>>>>>> Note that new fdb entries which are added manually or
>>>>>> as local ones are still permitted.
>>>>>> This patch has been tested by running traffic via a bridge port and
>>>>>> switching the port's state, also by manually adding/removing entries
>>>>>> from the bridge's fdb.
>>>>>>
>>>>>> Signed-off-by: Wilson Kok <wkok@cumulusnetworks.com>
>>>>>> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>>>>>
>>>>> What is the problem this is trying to solve?
>>>>>
>>>>> I think user should be allowed to manually add any entry
>>>>> even if learning.
>>>>
>>>> Hi Stephen,
>>>> I have been thinking about the use case and have discussed it
>>>> internally with colleagues and the patch
>>>> author, the main problem is when there's an external software that
>>>> adds dynamic entries (learning) and
>>>> it could experience a race condition, here's a possible situation:
>>>> * external software learns a mac from hw, sends an add to kernel
>>>>  * right before that, port goes blocking (or down) and kernel flushes
>>>>    mac, sends notification about the state change and mac flush
>>>>  * right after that, kernel gets the previous add from external software, it's
>>>>    allowed to add, and then sends an add notification
>>>>  * mean while, external software processes the link block/down and mac flush,
>>>>    followed by the mac add from kernel.  At this point, external software can't
>>>>    really know whether it's a user adding the mac intentionally or it's
>>>>    a race.
>>>>
>>>> This issue can't really be avoided in user-space.
>>>> As I've noted local and static entries are still allowed, and iproute2
>>>> bridge utility always
>>>> marks the entries as static (NUD_NOARP), this only affects external
>>>> dynamic entries which
>>>> are usually sent by something that does the learning externally.
>>>> I'll keep digging to see if there's another way to go about this since
>>>> I'd like to give the user
>>>> full freedom. Personally I don't have strong feeling for this patch
>>>> and if it's not preferred then
>>>> I'll post a revert.
>>>
>>> So there is already a switchdev API to add/del an externally learned
>>> FDB entry which holds rtnl_lock and avoids these races.  I would
>>> suggest using that and revert this patch.
>>>
>>> See call_switchdev_notifiers(SWITCHDEV_FDB_ADD|SWITCHDEV_FDB_DEL) and
>>> the handler in br.c:br_switchdev_event().
>>>
>>> -scott
>>
>> Hmm, I'm new to the switchdev API and am possibly missing something,
>> but how do you suggest to use it here ?
>
> You need to call
> call_switchdev_notifiers(SWITCHDEV_FDB_ADD|SWITCHDEV_FDB_DEL) when the
> device learns a new mac/vlan on the port interface.
>
>> How can we differentiate between user-added entry and an externally
>> learned one ?
>
> Externally added ones will be marked with NTF_EXT_LEARNED set in
> ndm->ndm_flags in the netlink echo.  Manually added ones from the user
> will have ndm->ndm_state set to NUD_NOARP in the netlink echo.
>

I meant between externally learned entries from a user-space daemon and manually
added by the user.

>> Do you mean to use (for example) the NTF_EXT_LEARNED flag when adding
>> an entry from user-space so
>> the API can get called in br_fdb_add ?
>
> No.  br_fdb_add is the bridge's .ndo_fdb_add handler called when user
> manually adds an FDB entry using netlink RTM_NEWNEIGH.  For externally
> learned entries, use the internal
> call_switchdev_notifiers(SWITCHDEV_FDB_ADD|SWITCHDEV_FDB_DEL).
>
> -scott

I got the API, but it doesn't help in the situation I explained
because it's a user-space
software that adds the externally learned entry, so I'm talking about
differentiating between externally learned dynamic entry from a device
which doesn't have
a kernel driver and can't call these notifiers, thus if we disallow
such dynamic entries when
the port is not in the proper state helps to both close the race and
fix the problem.
