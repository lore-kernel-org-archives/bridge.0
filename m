Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8BAD541514
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13B18414E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=8giTgAsje0PgfypLa6/wbiRAhOKG5Tbh9uzJ383M/Bs=;
 b=tKJjlthPnaEUALGlSwOgU2+cmYJtLc+oN99DlO8lq1Y7rInuuxKIEplRA+CkIQc4Zu
 /mSKlqcduxV+zRdt744Pc41wwC1FnsejAi7m+GVhafW7mWsC3youUYZO0ntc5V1XamCb
 U56HsOfaCcVYg4yp8enUA1c9MLNo3+yUCuJmKleWR5uRggQ6MYepwTz/ZLZLFR5hMRgW
 nic4oSRwTR8/ZjeeAQk5NcqHILD6IdjFBUzuG8mcJLKpdezZapamwLnr9V5Tk9RQFERp
 QpJz9yXqh7jlZYaG0gwhLA9GX/Y8WQdcQbZSxqkFftJ+p2pYV9vmNcJIUbEv6zisJIlO
 j+Xg==
Message-ID: <fe456fb0-4f68-f93e-d4a9-66e3bc56d547@blackwall.org>
Date: Thu, 7 Jul 2022 00:01:33 +0300
MIME-Version: 1.0
Content-Language: en-US
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
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220706202130.ehzxnnqnduaq3rmt@skbuf>
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

On 06/07/2022 23:21, Vladimir Oltean wrote:
> On Wed, Jul 06, 2022 at 10:38:04PM +0300, Nikolay Aleksandrov wrote:
>> I don't think that is new or surprising, if there isn't anything to control the
>> device resources you'll get there. You don't really need to write any new programs
>> you can easily do it with mausezahn. I have tests that add over 10 million fdbs on
>> devices for a few seconds.
> 
> Of course it isn't new, but that doesn't make the situation in any way better,
> quite the opposite...
> 
>> The point is it's not the bridge's task to limit memory consumption or to watch for resource
>> management. You can limit new entries from the device driver (in case of swdev learning) or
>> you can use a daemon to watch the number of entries and disable learning. There are many
>> different ways to avoid this. We've discussed it before and I don't mind adding a hard fdb
>> per-port limit in the bridge as long as it's done properly. We've also discussed LRU and similar
>> algorithms for fdb learning and eviction. But any hardcoded limits or limits that can break
>> current default use cases are unacceptable, they must be opt-in.
> 
> I don't think you can really say that it's not the bridge's task to
> limit memory consumption when what it does is essentially allocate
> memory from untrusted and unbounded user input, in kernel softirq
> context.
> 
> That's in fact the problem, the kernel OOM killer will kick in, but
> there will be no process to kill. This is why the kernel deadlocks on
> memory and dies.
> 
> Maybe where our expectations differ is that I believe that a Linux
> bridge shouldn't need gazillions of tweaks to not kill the kernel?
> There are many devices in production using a bridge without such
> configuration, you can't just make it opt-in.
> 

No, you cannot suddenly enforce such limit because such limit cannot work for everyone.
There is no silver bullet that works for everyone. Opt-in is the only way to go
about this with specific config for different devices and deployments, anyone
interested can set their limits. They can be auto-adjusted by swdev drivers
after that if necessary, but first they must be implemented in software.

If you're interested in adding default limits based on memory heuristics and consumption
I'd be interested to see it.

> Of course, performance under heavy stress is a separate concern, and
> maybe user space monitoring would be a better idea for that.
> 

You can do the whole software learning from user-space if needed, not only under heavy stress.

> I know you changed jobs, but did Cumulus Linux have an application to
> monitor and limit the FDB entry count? Is there some standard
> application which does this somewhere, or does everybody roll their own?
> 

I don't see how that is relevant.

> Anyway, limiting FDB entry count from user space is still theoretically
> different from not dying. If you need to schedule a task to dispose of

you can disable learning altogether and add entries from a user-space daemon, ie
implement complete user-space learning agent, theoretically you can solve it in
many ways if that's the problem

> the weight while the ship is sinking from softirq context, you may never
> get to actually schedule that task in time. AFAIK the bridge UAPI doesn't
> expose a pre-programmed limit, so what needs to be done is for user
> space to manually delete entries until the count falls below the limit.

That is a single case speculation, it depends on how it was implemented in the first place. You
can disable learning and have more than enough time to deal with it.

I already said it's ok to add hard configurable limits if they're done properly performance-wise.
Any distribution can choose to set some default limits after the option exists.

