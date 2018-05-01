Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=7cc5adfgC+sYzE1sQi8XwfW4phH+vhq4LvT2GjKoWmw=;
	b=TossOtJAkXztsX0F/+2ILQH7JC2gY2kLY8ZcfWtU47Y7UQVQeAnAiJ7k5T0FiY0S930udVvGtlFeo1oMzQlc7emLKxjeG62JwIUjQJYpB+AW9XA/9rjm1pVX7LVz3scEGW3R49TsYmbPT/uGUqJr7ZLaG2UFp1m7E/69FaIUl2w=
From: Petr Machata <petrm@mellanox.com>
References: <cover.1525194039.git.petrm@mellanox.com>
	<8934024270c83055e1e0e9468aafa3fe5e35e745.1525194039.git.petrm@mellanox.com>
	<df818113-33d4-d1ec-eb55-75e1aa59338d@cumulusnetworks.com>
Date: Wed, 02 May 2018 01:33:29 +0300
In-Reply-To: <df818113-33d4-d1ec-eb55-75e1aa59338d@cumulusnetworks.com>
	(Nikolay Aleksandrov's message of "Tue, 1 May 2018 20:49:15 +0300")
Message-ID: <wihfu3brop2.fsf@dev-r-vrt-156.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 2/2] net: bridge: Notify about
	!added_by_user FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: ivecera@redhat.com, andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, vivien.didelot@savoirfairelinux.com, netdev@vger.kernel.org, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, davem@davemloft.net

Nikolay Aleksandrov <nikolay@cumulusnetworks.com> writes:

> On 01/05/18 20:04, Petr Machata wrote:
>> Do not automatically bail out on sending notifications about activity on
>> non-user-added FDB entries. Instead, notify about this activity except
>> for cases where the activity itself originates in a notification, to
>> avoid sending duplicate notifications.
>>
>> Signed-off-by: Petr Machata <petrm@mellanox.com>
>> ---
>>   net/bridge/br.c           |  4 ++--
>>   net/bridge/br_fdb.c       | 40 +++++++++++++++++++++++++++-------------
>>   net/bridge/br_private.h   |  4 ++--
>>   net/bridge/br_switchdev.c |  2 +-
>>   4 files changed, 32 insertions(+), 18 deletions(-)
>>
>
> Hi Petr,
> We already have 7 different fdb delete functions, I'm really not a fan of
> adding yet another one for such trivial change.
> Why don't you just add the new notify parameter to the already existing
> fdb_delete() ? (actually about the name see below)
> IMO it's confusing - if one wants a notification then use fdb_delete() or __fdb_delete(true)
> vs __fdb_delete(false) if a notification is not required. I think simply having the last
> parameter everywhere for fdb_delete() shows the intention clearer and avoids another
> fdb delete function.

All right--this is how I had it written actually, but then decided to do
this wrapping, because so many of the calls end up being true. I'll send
a v2 with just the extra argument.

> Another point, the notify parameter has a confusing name in this context because
> you're controlling the switchdev notifications not the rtnetlink ones. I'd suggest
> changing the name to something more descriptive like swdev_notify, otherwise you
> could get the funny end result of calling __fdb_notify() with notify == false which
> to me means don't notify. :-)

OK, swdev_notify it will be.

> Also please add the bridge maintainers to the CC list.

bridge@lists.linux-foundation.org? I saw it's a moderated list and for
some reason that made me think it's not meant for patch postings. I'll
add them the next time.

Thanks,
Petr
