Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=wBFUwD8v7MY9tA3pfxaUDIRrNmd/tQok/JpxKmmt2es=;
	b=lAfCbT2k2DS3ytvibgd/nyoxQmqpo4xHxqgJXa/m6iA8KpoIINa6eGBSPwlBE8lgPa
	s9kG+zEUNXFxxjuXFTSwnW/NNdF/rFBsgZ/d2ahkKeahy2q/aYez4yTG9vN3C8hwZ8YG
	rfkRYIritoBY7MX/roBCjfw66iXZsX1i5YHtVZzoD3i2clSvLDQYtne1BlJJXX2WV8q6
	iYLke5qAsiw/Bj9ld58Fqs/aJObvMNA0lXE1fkQ2kJJ1HBmx1ySrDEY8Q1PgyLdjMUXj
	15JEF8Oh0Qvb4fazUXCt9q0LzQQaunb5qXo8kjey0yZ9ESQ4Rfscupeh3lIP0u1pxcgi
	DLUA==
Date: Mon, 5 Dec 2016 08:37:18 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20161205083718.0c0daa1a@xeon-e3>
In-Reply-To: <1480764803-5577-1-git-send-email-bianpan2016@163.com>
References: <1480764803-5577-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/1] net: bridge: set error code on failure
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pan Bian <bianpan2016@163.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Sat,  3 Dec 2016 19:33:23 +0800
Pan Bian <bianpan2016@163.com> wrote:

> Function br_sysfs_addbr() does not set error code when the call
> kobject_create_and_add() returns a NULL pointer. It may be better to
> return "-ENOMEM" when kobject_create_and_add() fails.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=188781
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  net/bridge/br_sysfs_br.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
> index e120307..f88c4df 100644
> --- a/net/bridge/br_sysfs_br.c
> +++ b/net/bridge/br_sysfs_br.c
> @@ -898,6 +898,7 @@ int br_sysfs_addbr(struct net_device *dev)
>  	if (!br->ifobj) {
>  		pr_info("%s: can't add kobject (directory) %s/%s\n",
>  			__func__, dev->name, SYSFS_BRIDGE_PORT_SUBDIR);
> +		err = -ENOMEM;
>  		goto out3;
>  	}
>  	return 0;

Makes sense. Although such a small allocation should never fail.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
