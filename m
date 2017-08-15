Return-Path: <sergei.shtylyov@cogentembedded.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=rK9aAFU2yzuYWRJgRo0wPPFIli4I8TK923Pc+YtvzZ4=;
	b=bjrT05ItvBVcBZn00ypMzOoy5ytvSfZAi1vPQYgvqPZhxsNoJhOkFC/zMocY4Eg6Wy
	vZ7zsDv8KO7louR0YnOlg0WRuwhSK2GQK7ScVYbARbIUzXHO+RGhezGeQwEryixaR8k6
	XxiG4h1OcH47HKgAG3gEZHd49Uxp+wAD7bWzT0k83SmeIe0iXHrE9cyWmImcesTFKs4Q
	FwyP5XcGG7UNi4qz3l082tYzmH8uXbyO2ub2t0RlZLsvfouINohtzj7xxXE0FfkxA0Dh
	uOck3oNpBARavEn+2zaIdWk0SDyyC1uATNeBL3yiCSXHGJqdpLqRSUXMMe+u6Dy2iGG+
	S7og==
References: <20170815065025.18471-1-colin.king@canonical.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <6b38b83c-21b3-5cec-6145-cdbb54a63dd2@cogentembedded.com>
Date: Tue, 15 Aug 2017 12:45:37 +0300
MIME-Version: 1.0
In-Reply-To: <20170815065025.18471-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] netfilter: fix indent on in statements
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Colin King <colin.king@canonical.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Florian Westphal <fw@strlen.de>, Stephen Hemminger <stephen@networkplumber.org>, "David S . Miller" <davem@davemloft.net>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello!

On 8/15/2017 9:50 AM, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> The returns on some if statements are not indented correctly,

    s/in/if/ in the subject?

> add in the missing tab.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
[...]

MBR, Sergei
