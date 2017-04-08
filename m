Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=xULWiIa1ytjcChpwBwF/Y3gBMxq9+JA4zgWvxH5xEyU=;
	b=FcsXEOY90JnLHea4O7gm7usUQiS9cmJ2OtfliGOrdNzkVlewj10WlRBxO8QNoQRtoU
	uJyFa3QruBKvSplbALkiJXH4jvd8xFY8avzQlUJ1tG8XFtLHgR4cE+VB2fJoTwHdhSbm
	9eMvSOgdFwmVRuKw/I+SPfp1/2AEF52XukLkoSR/GCwJ5bhUwbHvuS8R3g5tgYvX64KV
	PXKO6qorKq56ik0+LqDLxu8OZMDKIhYt73NO6w3gUJCt+/R86lFqZt9eozG2DLccz5EM
	YZ5AISCs2d6XH77l9TaAzXuagIRffsie0JKx8SuQ0zQApISY3F9FygIS7tinYo7l6umO
	gDqw==
Date: Sat, 8 Apr 2017 09:32:44 -0400
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170408093244.593a8624@plumbers-lap.home.lan>
In-Reply-To: <20170408114159.12722-3-idosch@mellanox.com>
References: <20170408114159.12722-1-idosch@mellanox.com>
	<20170408114159.12722-3-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v2 2/2] bridge: netlink: register netdevice
 before executing changelink
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: idosch@mellanox.com
Cc: cera@cera.cz, mlxsw@mellanox.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, peter@svinota.eu, bridge@lists.linux-foundation.org, davem@davemloft.net

On Sat, 8 Apr 2017 14:41:59 +0300
<idosch@mellanox.com> wrote:

> +	err = br_changelink(dev, tb, data);
> +	if (err)
> +		goto unregister;
> +
> +	return 0;
> +
> +unregister:
> +	unregister_netdevice(dev);
> +	return err;
>  }

Why use a goto? just do:
	err = br_changelink(dev, tb, data);
	if (err)
		unregister_netdevice(dev)
	return err;
}


The goto looks ugly
