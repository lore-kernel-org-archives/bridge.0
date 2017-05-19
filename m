Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=z5oLISyFVgO1KWV2gffDAM/hoIcVrMyH2PCO6ulwcEE=;
	b=VP8mQREcmipkHAPi9iry4UKjuQnu6rqhIQOIef3Tj7Fh/DvSbTTlVhN2XUZgQi8K3y
	lW7sMg5xO/v/WE1Db4Li09bf70SI/gcWTOO3rof1ZPTh5rkZlACrH9IY5RjSqs5OZv/S
	Eag+YVO14Pa23nYVxm/u2u1r524jysEi1eXPk=
References: <20170519173043.10201-1-cera@cera.cz>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <6c14d4a9-0fc8-aa28-7c73-99ad5e0fbef5@cumulusnetworks.com>
Date: Fri, 19 May 2017 23:12:45 +0300
MIME-Version: 1.0
In-Reply-To: <20170519173043.10201-1-cera@cera.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] bridge: fix hello and hold timers
 starting/stopping
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ivan Vecera <cera@cera.cz>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, lucien.xin@gmail.com, davem@davemloft.net

On 5/19/17 8:30 PM, Ivan Vecera wrote:
> Current bridge code incorrectly handles starting/stopping of hello and
> hold timers during STP enable/disable.
> 
> 1. Timers are stopped in br_stp_start() during NO_STP->USER_STP
>     transition. The timers are already stopped in NO_STP state so
>     this is confusing no-op.
> 
> 2. During USER_STP->NO_STP transition the timers are started. This
>     does not make sense and is confusion because the timer should not be
>     active in NO_STP state.
> 
> Cc: davem@davemloft.net
> Cc: sashok@cumulusnetworks.com
> Cc: stephen@networkplumber.org
> Cc: bridge@lists.linux-foundation.org
> Cc: lucien.xin@gmail.com
> Cc: nikolay@cumulusnetworks.com
> Signed-off-by: Ivan Vecera <cera@cera.cz>
> ---
>   net/bridge/br_stp_if.c | 11 -----------
>   1 file changed, 11 deletions(-)
> 

LGTM, thanks!

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


