Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=37uxmF3+2Dg1v37S5qsmwgX3AD5HD5u5k21qUyrvLY8=;
	b=aM6pmgpxMfi9zyczRVJBbMaJZsqZlFnQ+cE2+szKG79OYh8dO6q6mXzYt3u/2UxLHe
	rISZiL8bVSFZO17R0cUim2rK0tO3BeCePdF4lAPcunfq9rA6jbvugZt01uZR5DxDM9B3
	r7pxP6ys4NWFI14Atvg9yCDYTrnmpbA77iX5E=
References: <cover.1525194039.git.petrm@mellanox.com>
	<8934024270c83055e1e0e9468aafa3fe5e35e745.1525194039.git.petrm@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <df818113-33d4-d1ec-eb55-75e1aa59338d@cumulusnetworks.com>
Date: Tue, 1 May 2018 20:49:15 +0300
MIME-Version: 1.0
In-Reply-To: <8934024270c83055e1e0e9468aafa3fe5e35e745.1525194039.git.petrm@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org
Cc: ivecera@redhat.com, andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, vivien.didelot@savoirfairelinux.com, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, davem@davemloft.net

On 01/05/18 20:04, Petr Machata wrote:
> Do not automatically bail out on sending notifications about activity on
> non-user-added FDB entries. Instead, notify about this activity except
> for cases where the activity itself originates in a notification, to
> avoid sending duplicate notifications.
> 
> Signed-off-by: Petr Machata <petrm@mellanox.com>
> ---
>   net/bridge/br.c           |  4 ++--
>   net/bridge/br_fdb.c       | 40 +++++++++++++++++++++++++++-------------
>   net/bridge/br_private.h   |  4 ++--
>   net/bridge/br_switchdev.c |  2 +-
>   4 files changed, 32 insertions(+), 18 deletions(-)
> 

Hi Petr,
We already have 7 different fdb delete functions, I'm really not a fan of
adding yet another one for such trivial change.
Why don't you just add the new notify parameter to the already existing
fdb_delete() ? (actually about the name see below)
IMO it's confusing - if one wants a notification then use fdb_delete() or __fdb_delete(true)
vs __fdb_delete(false) if a notification is not required. I think simply having the last
parameter everywhere for fdb_delete() shows the intention clearer and avoids another
fdb delete function.

Another point, the notify parameter has a confusing name in this context because
you're controlling the switchdev notifications not the rtnetlink ones. I'd suggest
changing the name to something more descriptive like swdev_notify, otherwise you
could get the funny end result of calling __fdb_notify() with notify == false which
to me means don't notify. :-)

Also please add the bridge maintainers to the CC list.

Thanks,
  Nik
