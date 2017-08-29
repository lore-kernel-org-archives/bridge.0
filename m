Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=QQ3b1ph9QN/ecfSJ1D7VcTLKbwEjNhLzVVyYsvCG7to=;
	b=AtphGnR1FxmnO7qRjrqr/xIrhmdunIvUIXzPzLWnHAE37ymkzpOy5CAttoW6O0osnW
	tHjMdi+LHrdfK2J1m4+wmll3qhR7zBAwZZUBBtoWGhvjfZxWOy3FAi5EKnt2BRE15GdY
	woh5tXf8pm4M8aG+3Mpow0VOezjsvHgtiAw0s92slKn4oZxZw/cEvOJv+rB3YVCiBuvb
	CQsM61gBpoDQfrPH24ri91jvb2kxiuRcDkPfJh3tFfdfQfAQesHLlcP3qD1q7EMU0eoJ
	p3AqPcdr4oSsJiXDoghGckL8rkHSvWOQJh5oYY6I1osJyymjuFiT7XtEoRW5CUlaCeWu
	h5og==
References: <1503980568-35240-1-git-send-email-roopa@cumulusnetworks.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8737eb73-3437-5529-6f4d-7aa52c770357@gmail.com>
Date: Tue, 29 Aug 2017 09:46:05 -0700
MIME-Version: 1.0
In-Reply-To: <1503980568-35240-1-git-send-email-roopa@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] bridge: fdb add and delete
	tracepoints
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@cumulusnetworks.com>, davem@davemloft.net
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On 08/28/2017 09:22 PM, Roopa Prabhu wrote:
> From: Roopa Prabhu <roopa@cumulusnetworks.com>
> 
> A few useful tracepoints to trace bridge forwarding
> database updates.
> 
> Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Small nit below, but probably not a candidate for a v3

> ---

> +
> +	TP_printk("dev %s addr %02x:%02x:%02x:%02x:%02x:%02x vid %u nlh_flags %04x ndm_flags = %02x",

Small nit, any particular reason why ndm_flags got a special treatment
with an equal character and not the other?

> +		  __get_str(dev), __entry->addr[0], __entry->addr[1],
> +		  __entry->addr[2], __entry->addr[3], __entry->addr[4],
> +		  __entry->addr[5], __entry->vid,
> +		  __entry->nlh_flags, __entry->ndm_flags)
-- 
Florian
