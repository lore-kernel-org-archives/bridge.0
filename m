Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=6va+JHT0bDh5ZxHr2ygNdw45QrcrtSj8SP8KvJocRRw=;
	b=UpTPUU2cQoimtua8UGuzzZTY545XgLRUrQvIkc22ts7CIBD7nalg+2s/1JtpoUl0s/
	OghFzJUZ9UZmN/iHHCZVqZDzDQirCZX5POy7TBNrIQQoTKTIvzJWNE6DeIKNjXD7nfsc
	QElKrrZ3VFcgt2/Q8bYRbEN9oItRjWvmKO1dA=
References: <cover.1525350809.git.petrm@mellanox.com>
	<33ac8ce3fcd084190c5797a409ebd7858f7d47db.1525350809.git.petrm@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <39b65224-cd35-4716-1a8c-cc1bfaff0654@cumulusnetworks.com>
Date: Thu, 3 May 2018 15:56:33 +0300
MIME-Version: 1.0
In-Reply-To: <33ac8ce3fcd084190c5797a409ebd7858f7d47db.1525350809.git.petrm@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next mlxsw v2 2/2] net: bridge: Notify
 about !added_by_user FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: ivecera@redhat.com, f.fainelli@gmail.com, andrew@lunn.ch, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, davem@davemloft.net

On 03/05/18 15:43, Petr Machata wrote:
> Do not automatically bail out on sending notifications about activity on
> non-user-added FDB entries. Instead, notify about this activity except
> for cases where the activity itself originates in a notification, to
> avoid sending duplicate notifications.
> 
> Signed-off-by: Petr Machata <petrm@mellanox.com>
> ---
>   net/bridge/br.c           |  4 ++--
>   net/bridge/br_fdb.c       | 47 ++++++++++++++++++++++++++---------------------
>   net/bridge/br_private.h   |  6 ++++--
>   net/bridge/br_switchdev.c |  2 +-
>   4 files changed, 33 insertions(+), 26 deletions(-)
> 

Thanks, looks good to me! In the future please add the reviewers to the CC list
when sending a v2, I actually missed the v2 set and saw your reply to the cover
letter patch later.

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

