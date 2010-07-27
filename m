MIME-Version: 1.0
In-Reply-To: <AANLkTinFv+mi35FJ=q1AeKoGsmKt9mP60wb_7578eEMb@mail.gmail.com>
References: <AANLkTinFv+mi35FJ=q1AeKoGsmKt9mP60wb_7578eEMb@mail.gmail.com>
Date: Tue, 27 Jul 2010 14:58:13 +0100
Message-ID: <AANLkTinkF8VQoBQpYbj6NteTAczwp+_-bZzk4vOtJXTm@mail.gmail.com>
From: Jarrod Lowe <jarrod.lowe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] Bridging and NAT: Confusion when linux sees the packet
	for a second time
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

On 27 July 2010 13:12, Jarrod Lowe <jarrod.lowe@gmail.com> wrote:
>
> Hi,
>
> I have a rather odd problem.
>
> This is a bit of a complicated setup, if you want to know why, I have included more detail at the bottom.

Joy, I can answer my own question.

It was indeed conntrack screwing up.

The rule:
  iptables -A PREROUTING -t raw (some suitable conditions) -j NOTRACK
where "some suitable conditions match the packet as seen the second
time (In my case, I could use that they were on the internal network,
but the IPs were neither to nor from the internal network).

It would be nicer to be able to say that all bridging but non-routing
traffic was NOTRACK, but the above will do.

Thanks,
--
Jarrod Lowe
