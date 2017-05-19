Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=XuDzWfhKvjY5lxnMk0ZoRN9MBzugSn39CLtt5u1I7Pw=;
	b=Ceg+zQh4nv5nwtC6C6yHUTy9bhFxCFrBIbrCn0fJibI1b9z6VI0q7XPhikAHj+Lh8y
	eJtB1x1oHN/DBwVNevIiRAdxbzzXHucDUrviwsMylHvLX2LuM1z6h/nA9y+bFIcb5JRh
	+odAxDblYgEd5oRiwUR+gHReHzsgL9BRGFVZgdbzCnbcdzbdSy5xi9kjE05j8s8Ho6zO
	4Za/N2MJqYr/GVKq5JOUHXYgk/+1HbraHmf/IC2u1bjGP47Q7wKZ2v5PZ37eP1sBeuN3
	aCKeKMznMNYqKoRi69NUFfLndSpEWDCs744rxnMMn2/wEo7uWeZowvQGaB5o5GDjW9aD
	P3Eg==
Date: Fri, 19 May 2017 09:38:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170519093816.2b556a1b@xeon-e3>
In-Reply-To: <20170519162543.31670-1-cera@cera.cz>
References: <20170519162543.31670-1-cera@cera.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: fix hello and hold timers
	starting/stopping
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ivan Vecera <cera@cera.cz>
Cc: lucien.xin@gmail.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net

On Fri, 19 May 2017 18:25:43 +0200
Ivan Vecera <cera@cera.cz> wrote:

> Current bridge code incorrectly handles starting/stopping of hello and
> hold timers during STP enable/disable.
> 
> 1. Timers are stopped in br_stp_start() during NO_STP->USER_STP
>    transition. This is not correct as the timers are stopped in NO_STP
>    case.
> 
> 2. Timers are started in br_stp_stop() during USER_STP->NO_STP transition.
>    This is not also correct as the timers should be stopped in NO_STP
>    state.
> 
> 3. Timers are NOT stopped in br_stp_stop() during KERNEL_STP->NO_STP
>    transition. They should be stopped as they are running in KERNEL_STP
>    state and should not run in NO_STP case.
> 
> The patch is a follow-up for "bridge: start hello_timer when enabling
> KERNEL_STP in br_stp_start" patch from Xin Long.
> 
> Cc: davem@davemloft.net
> Cc: sashok@cumulusnetworks.com
> Cc: stephen@networkplumber.org
> Cc: bridge@lists.linux-foundation.org
> Cc: lucien.xin@gmail.com
> Cc: nikolay@cumulusnetworks.com
> Signed-off-by: Ivan Vecera <cera@cera.cz>

Overall, this looks correct but the wording of commit message
is too terse.

It would be better to add a more complete description of the impact
of this from a user's point of view. I am concerned that this
might have other side effects.

For example, what is the sequence of commands to validated this.

What is the impact, should this go to stable?


