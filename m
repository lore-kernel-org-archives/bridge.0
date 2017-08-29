Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=qFNQcW1vMvhs9VqCCMHGBHBL+avoIiRy/iAdAYC6EQQ=;
	b=jAqpa24etyd9q+i2mv/INgcsXmpT9+4Mp85XoNv6JhV3utdcPwYA40RbJL09HRmtXV
	AofqQhDwPJuJYiLWBxv8v3IX2iTFgAdqtTvd4PyXVdRzhFQZYSbs2WcGdGNwSeFanO1n
	p74FotMwLJNtWJX7u9I8PJAHhi5dVhChiDdbbl6a0p8FPwqUfpkQ+0mPoALq7kpBMvYZ
	VHp0bfepd1R4BGU82d4CF1qDQczWsRXiBIfMLJyNMgk2Kbikr+oE6MKykH1uFdosCmYF
	BlXsCBkAsv3wYdkAPNMTKEe6we5TLiv8WytGbLtH7+nn+cpNIhEq3TdMCSg05hIXxRZ6
	ZRcA==
References: <1504037817-38107-1-git-send-email-roopa@cumulusnetworks.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <dc7f0ac9-b2b8-13ca-0004-c288345d3002@gmail.com>
Date: Tue, 29 Aug 2017 13:30:11 -0700
MIME-Version: 1.0
In-Reply-To: <1504037817-38107-1-git-send-email-roopa@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3] bridge: fdb add and delete
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

On 08/29/2017 01:16 PM, Roopa Prabhu wrote:
> From: Roopa Prabhu <roopa@cumulusnetworks.com>
> 
> A few useful tracepoints to trace bridge forwarding
> database updates.
> 
> Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

thanks for quick turnaround!
-- 
Florian
