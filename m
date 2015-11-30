Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding;
	bh=XrxjGss4ifBoJYGApXxggSDFp5ymM6KBNYrGZZ6kGMQ=;
	b=C5KCn+TpkB2+1gs6z7KV8C9abqB/u1K4VzBoEKbjvKUKSLCs6LkqYk1GJ1r1cE1sTO
	anC/+/gYWCfnP+hCjRq5Pgr5sUhWAvakAExaQ08p2Wz+QQ9lxd/xzIwFWa/oOajHKpkG
	LTNcfLFP4akBddV02i2mHtn8c6eTlXXWm9UPYkYb3kbIGnT7GqK6MRb2UWqoRsfwNNl+
	K/R+KaaV56zK//H2KXtvaypqJ08HUBvBtrT5i96c8kK4ztqghMipvcKhZWX9fsQJsNP1
	94CzgNvAozxpi6owGBSp6xjetvMKCzH3wjJJ6oYa71vKneTrv8l/FJ/NSw/LiIg3o+Kp
	Zu4w==
Date: Mon, 30 Nov 2015 14:12:08 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20151130141208.516b1046@xeon-e3>
In-Reply-To: <87egf7183c.fsf_-_@x220.int.ebiederm.org>
References: <565B7F7D.80208@nod.at>
	<CAGXu5jJqQKAmFK0nL69E0QOpo8WSVDqStGZo7-m7gy3vnXBa=A@mail.gmail.com>
	<87egf7183c.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: Only call /sbin/bridge-stp for the
 initial network namespace
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Richard Weinberger <richard@nod.at>, bridge@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>

On Mon, 30 Nov 2015 15:38:15 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> 
> There is no defined mechanism to pass network namespace information
> into /sbin/bridge-stp therefore don't even try to invoke it except
> for bridge devices in the initial network namespace.
> 
> It is possible for unprivileged users to cause /sbin/bridge-stp to be
> invoked for any network device name which if /sbin/bridge-stp does not
> guard against unreasonable arguments or being invoked twice on the same
> network device could cause problems.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  net/bridge/br_stp_if.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index 5396ff08af32..742fa89528ab 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -142,7 +142,9 @@ static void br_stp_start(struct net_bridge *br)
>  	char *envp[] = { NULL };
>  	struct net_bridge_port *p;
>  
> -	r = call_usermodehelper(BR_STP_PROG, argv, envp, UMH_WAIT_PROC);
> +	r = -ENOENT;
> +	if (dev_net(br->dev) == &init_net)
> +		r = call_usermodehelper(BR_STP_PROG, argv, envp, UMH_WAIT_PROC);

I don't think this will cause loud screams.
But it might break people that use containers to run virtual networks for testing.

One coding nit:
Why are you afraid of using an else?

