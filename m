Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=xlNP/el/CDzOxrQolLFrHnKrrk7DUEoX+0ImXIXypPY=;
	b=d/LvZJshgJ9UO33sfLH5P04rQlpaLVovxHWwf6RoSq6XzM1ByR5zusUVYwDIhL5fIS
	KSdQHCMkgV5RWyuQZaYJwAy3fDBfue9ta0w0gzhgz9remqoWCm7o2hO7Dp/fEV5Gs1r/
	KA8QxlfXMGx5XQDrxJP+RiMD7nI5T+wnRt0AY=
MIME-Version: 1.0
In-Reply-To: <20150526102809.5c3e8abc@urahara>
References: <1432204977-4293-1-git-send-email-nikolay@cumulusnetworks.com>
	<20150526102809.5c3e8abc@urahara>
Date: Wed, 27 May 2015 09:05:32 +0200
Message-ID: <CABQ03vEQhdXgWk5r103Yd0CPxEWuU3i0m8ztQjtgR0NFDbEXRQ@mail.gmail.com>
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
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>, Wilson Kok <wkok@cumulusnetworks.com>

On Tue, May 26, 2015 at 7:28 PM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Thu, 21 May 2015 03:42:57 -0700
> Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
>
>> From: Wilson Kok <wkok@cumulusnetworks.com>
>>
>> Check in fdb_add_entry() if the source port should learn, similar
>> check is used in br_fdb_update.
>> Note that new fdb entries which are added manually or
>> as local ones are still permitted.
>> This patch has been tested by running traffic via a bridge port and
>> switching the port's state, also by manually adding/removing entries
>> from the bridge's fdb.
>>
>> Signed-off-by: Wilson Kok <wkok@cumulusnetworks.com>
>> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>
> What is the problem this is trying to solve?
>
> I think user should be allowed to manually add any entry
> even if learning.

Hi Stephen,
I have been thinking about the use case and have discussed it
internally with colleagues and the patch
author, the main problem is when there's an external software that
adds dynamic entries (learning) and
it could experience a race condition, here's a possible situation:
* external software learns a mac from hw, sends an add to kernel
 * right before that, port goes blocking (or down) and kernel flushes
   mac, sends notification about the state change and mac flush
 * right after that, kernel gets the previous add from external software, it's
   allowed to add, and then sends an add notification
 * mean while, external software processes the link block/down and mac flush,
   followed by the mac add from kernel.  At this point, external software can't
   really know whether it's a user adding the mac intentionally or it's
   a race.

This issue can't really be avoided in user-space.
As I've noted local and static entries are still allowed, and iproute2
bridge utility always
marks the entries as static (NUD_NOARP), this only affects external
dynamic entries which
are usually sent by something that does the learning externally.
I'll keep digging to see if there's another way to go about this since
I'd like to give the user
full freedom. Personally I don't have strong feeling for this patch
and if it's not preferred then
I'll post a revert.

Thanks,
 Nik
