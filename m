Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=ToEF9cntRQoOQoYCpbOuZQ4J0IwMSfZEIM0C0evlaJY=;
	b=SjRtdO9JmRphiXMVXWpYPIyM6lmhNdb6yIhEib6WTqNMz9XQFqoYu0EcnFf1LmJsHX
	HpeYk+y5vmvulKBBig1D4JAzgTQ9pnK2c01XXFXmYOAB/X7Aqb5mr1UYt6/BN0YeUHvH
	VojluqZpXihqOljQ5Ms46D4dtUBVdJ4OhIVNQ=
MIME-Version: 1.0
In-Reply-To: <20150524.225902.2017701461230237731.davem@davemloft.net>
References: <1432204977-4293-1-git-send-email-nikolay@cumulusnetworks.com>
	<20150524.225902.2017701461230237731.davem@davemloft.net>
Date: Mon, 25 May 2015 13:41:20 +0200
Message-ID: <CABQ03vG0FG5qs9EwjAeKoZv2k2Eez58v6oEjj4HoHY8wN8s34g@mail.gmail.com>
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
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Wilson Kok <wkok@cumulusnetworks.com>

On Mon, May 25, 2015 at 4:59 AM, David Miller <davem@davemloft.net> wrote:
> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Date: Thu, 21 May 2015 03:42:57 -0700
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
>> ---
>> Nik: Maybe it'd be better if we returned an error even though it
>>      doesn't look necessary. I'm open to suggestions.
>
> If you don't return an error, then rtnetlink.c is going to emit a
> NEWNEIGH netlink message.  I seriously doubt we want that to happen.

Thanks Dave, I was afraid I've missed something like that. I'll re-spin, test
and post a v2.

Nik
