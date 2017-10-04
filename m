Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=2E/7VkEdPxx16QynB7ELpCA2QqDNUEiVVc4SMvOeQwc=;
	b=ulKVkk7gy52ZBUAW661GBUqvxPu7JaHqNDezkwhty//JHmmqWUOKUiUZws2YlDchWO
	mhZoZCDsx9S6GiiAg3txNOjRMgmfjtu9nRuLmUkw1lUmFtQIebl6tLaMQTiliNWYnY+7
	RSMDMV70wiuWaqlIhaBCKlPJUxPMyPCvGvdJlyXKFifdsptejiG1GXV22QEJ0ZBp26z2
	k44iySEMXEzNKNG48eflYwooG9oclV/pgsY9KjA51Fv6N90q66Hdpl+KmWbPA0BxJCtp
	DjL1QiTn59knOOiyhWcKhAZ8Ayuqanfas5R1IH82WSWTZZZTPUGgfSiK0qOx4/fG5UHq
	1LUA==
Date: Wed, 4 Oct 2017 08:13:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20171004081357.37bfd941@xeon-e3>
In-Reply-To: <1507093134-20406-7-git-send-email-dsahern@gmail.com>
References: <1507093134-20406-1-git-send-email-dsahern@gmail.com>
	<1507093134-20406-7-git-send-email-dsahern@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 6/7] net: bridge: Pass extack to down
 to netdev_master_upper_dev_link
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, vfalico@gmail.com, j.vosburgh@gmail.com, davem@davemloft.net

On Tue,  3 Oct 2017 21:58:53 -0700
David Ahern <dsahern@gmail.com> wrote:

> Pass extack arg to br_add_if. Add messages for a couple of failures
> and pass arg to netdev_master_upper_dev_link.
> 
> Signed-off-by: David Ahern <dsahern@gmail.com>

This looks good. You might want to pass the netlink_ext_ack down as
an immutable pointer (const).

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
