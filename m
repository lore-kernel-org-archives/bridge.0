Return-Path: <lucien.xin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc; bh=1TDD9+iyGGWKGHAvoBjhr1hgggY012TkvXRp2MhQX6A=;
	b=oSycgZucfJLRduQTfWW/B2BO+Xe81e3KXucGQfVuAH9BDipb96c63AAvJeZ5d5XOOi
	gusud1YbM+0Eol+CWfW9ZUnkSVAlmiMluoZj9aaMVFBIZGhpTKsQAW2BLW8dQY2cxGSc
	vwebrBSCFZFPE875dtfXz+HZzZHVBMZFxFJEhCWbx8k5jOCA3WUvUTGRfmHec6m53sUH
	KZW4QjSbJOHKzwG6HO+Ql45jFCycp8tD8aH1WwCUlCZ/dSrDsfJYjPp/EXpCcrpfP0j3
	9c6nYHeecQqXWjgAPIv++m0dF0HstIOjosP4USDK/j037TAAsL+ljC0c20OjXijuDa+L
	GiOg==
MIME-Version: 1.0
In-Reply-To: <20160406.161043.260012491646006960.davem@davemloft.net>
References: <6197a35a2eb6df2caf90edcbf1b49da12077f659.1459827115.git.lucien.xin@gmail.com>
	<baf4788b6ac529a2132ace735fc1caf4989307da.1459827115.git.lucien.xin@gmail.com>
	<5703483D.80109@lab.ntt.co.jp>
	<20160406.161043.260012491646006960.davem@davemloft.net>
Date: Thu, 7 Apr 2016 11:49:23 +0800
Message-ID: <CADvbK_cc3a8g-8AVEK4GuQXhq9zUgJh72vq3MARiDYNN-2B-qw@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [PATCHv2 net-next 3/6] bridge: simplify the
 stp_state_store by calling store_bridge_parm
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, network dev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org

On Thu, Apr 7, 2016 at 4:10 AM, David Miller <davem@davemloft.net> wrote:
> From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> Date: Tue, 5 Apr 2016 14:08:13 +0900
>
>> On 2016/04/05 12:32, Xin Long wrote:
>>> There are some repetitive codes in stp_state_store, we can remove
>>> them by calling store_bridge_parm.
>>>
>>> Signed-off-by: Xin Long <lucien.xin@gmail.com>
>>> ---
>>>  net/bridge/br_sysfs_br.c | 24 +++++++-----------------
>>>  1 file changed, 7 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
>>> index 137cd3b..9918763 100644
>>> --- a/net/bridge/br_sysfs_br.c
>>> +++ b/net/bridge/br_sysfs_br.c
>>> @@ -128,27 +128,17 @@ static ssize_t stp_state_show(struct device *d,
>>>  }
>>>
>>>
>>> +static int set_stp_state(struct net_bridge *br, unsigned long val)
>>> +{
>>
>> You forgot to add rtnl lock here?
>> The missing lock is restored in patch 4, but at this point bisect could
>> break..
OK, if I will fix this, if there's no other issues on this patchset,
I will post v3 later.
Thanks.

>
> Agreed, this has to be fixed.
