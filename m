Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Elh5CHuxsFFmJf+/uXs4/5CNq5kWiDD1V9djTyV+LjM=;
	b=XRcsN+8u13GHXibAzkyVco6QiXHZuNWMGDFCpHUkjGJu6kew6eh/IHKK0z1JHwfO+z
	/TgCop/kMQSD8O1jwacQ4WWK9smZj0rPVUqp5ctqeGA852Svos4pEG+Q3Dsjgl3N6wUe
	c2WpNHkM7oVkxTNjg27sxfNBpzIQbjlx4c6vY=
References: <20181030091828.4i5x354yigemnfmo@kili.mountain>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <20199cec-dc75-c566-4c43-c1d4b86116c2@cumulusnetworks.com>
Date: Tue, 30 Oct 2018 11:59:04 +0200
MIME-Version: 1.0
In-Reply-To: <20181030091828.4i5x354yigemnfmo@kili.mountain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [bug report] net: bridge: add support for raw sysfs
	port options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: bridge@lists.linux-foundation.org

On 30/10/2018 11:18, Dan Carpenter wrote:
> Hello Nikolay Aleksandrov,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch a5f3ea54f3cc: "net: bridge: add support for raw sysfs port 
> options" from Jul 23, 2018, leads to the following Smatch complaint:
> 
>     net/bridge/br_sysfs_if.c:323 brport_store()
>      warn: variable dereferenced before check 'p->dev' (see line 317)
> 
> net/bridge/br_sysfs_if.c
>    316	
>    317		if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
>                                         ^^^^^^
> Dereferenced here.
> 
>    318			return -EPERM;
>    319	
>    320		if (!rtnl_trylock())
>    321			return restart_syscall();
>    322	
>    323		if (!p->dev || !p->br)
>                     ^^^^^^^
> Hopefully this can't happen?
> 
>    324			goto out_unlock;
>    325	
> 
> regards,
> dan carpenter
> 

Hi Dan,
Thank you for the report, but I think these checks are there for historic reasons.
Checking new_nbp() and del_nbp() it should not be possible to reach that code
with p->dev or p->br as NULL. The cap check code has always been there, I just
shuffled the rest of the function to obtain rtnl lock and kept it as close to
the original as possible, thus the checks remained.
In order to avoid future reports like this I'll send a cleanup once net-next
opens up.

My reasoning of why it shouldn't be possible:
- On port add new_nbp() sets both p->dev and p->br before creating kobj/sysfs

- On port del (trickier) del_nbp() calls kobject_del() before call_rcu() to destroy
  the port which in turn calls sysfs_remove_dir() which uses kernfs_remove() which
  deactivates (shouldn't be able to open new files) and calls kernfs_drain() to drain
  current open/mmaped files in the respective dir before continuing, thus making it
  impossible to open a bridge port sysfs file with p->dev and p->br equal to NULL.


I'll move the null checks above the cap check.

Thanks again,
 Nik

