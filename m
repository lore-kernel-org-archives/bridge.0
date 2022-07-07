Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 632B783F5F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7F7D83F5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language
 :from:to:cc:references:in-reply-to:content-transfer-encoding;
 bh=6rY/dl2MwiNlzvD+cvp/Yehm/zk9+xvHGZcTY6Q3tHo=;
 b=t2gX55YR3zd30kvhnujoohIF5s3d5CO/xyZejpLQSF+S5o/KrNLttMvJGTX1oeAjn9
 vUCeZ3TJi/rcNK7qQ1Ct4cYa2MdcUQ5w3TAQWCzbegoVLC9jJUqhZsuk6UC9qRFYK0Jq
 4Pa/LZd9tsDU9Smmw84BbYJ60cIMADLrUl16WWi4ggOr+WMPbloLywj0iIASQzgtvL+W
 twSlbGH2fS+itudRcqd43RuWsrM5v+Zi/wuYlFYG7umyfM8/7pMf2mkdyeF2eMljZLjd
 3h+JBbNnjz573UvruSiquB6tfr6VgxiQdqKw/qQLBOn3YYt16vK+C8JF0HVcIuu7SsYb
 Tvuw==
Message-ID: <37d59561-6ce8-6c5f-5d31-5c37a0a3d231@blackwall.org>
Date: Thu, 7 Jul 2022 17:08:15 +0300
MIME-Version: 1.0
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
References: <20220524152144.40527-2-schultz.hans+netdev@gmail.com>
 <01e6e35c-f5c9-9776-1263-058f84014ed9@blackwall.org>
 <86zgj6oqa9.fsf@gmail.com>
 <b78fb006-04c4-5a25-7ba5-94428cc9591a@blackwall.org>
 <86fskyggdo.fsf@gmail.com>
 <040a1551-2a9f-18d0-9987-f196bb429c1b@blackwall.org>
 <86v8tu7za3.fsf@gmail.com>
 <4bf1c80d-0f18-f444-3005-59a45797bcfd@blackwall.org>
 <20220706181316.r5l5rzjysxow2j7l@skbuf>
 <7cf30a3e-a562-d582-4391-072a2c98ab05@blackwall.org>
 <20220706202130.ehzxnnqnduaq3rmt@skbuf>
 <fe456fb0-4f68-f93e-d4a9-66e3bc56d547@blackwall.org>
In-Reply-To: <fe456fb0-4f68-f93e-d4a9-66e3bc56d547@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH V3 net-next 1/4] net: bridge: add fdb flag to
 extent locked port feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Hans Schultz <schultz.hans@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On 07/07/2022 00:01, Nikolay Aleksandrov wrote:
> On 06/07/2022 23:21, Vladimir Oltean wrote:
>> On Wed, Jul 06, 2022 at 10:38:04PM +0300, Nikolay Aleksandrov wrote:
[snip]
> I already said it's ok to add hard configurable limits if they're done properly performance-wise.
> Any distribution can choose to set some default limits after the option exists.
> 

Just fyi, and to avoid duplicate efforts, I already have patches for global and per-port software
fdb limits that I'll polish and submit soon (depending on time availability, of course). If I find
more time I might add per-vlan limits as well to the set. They use embedded netlink attributes
to config and dump, so we can easily extend them later (e.g. different action on limit hit, limit
statistics etc).

