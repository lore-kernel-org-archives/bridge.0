Date: Fri, 14 Dec 2007 08:56:02 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Packet per Second
Message-ID: <20071214085602.11a09070@deepthought>
In-Reply-To: <nemoFri121407105527@flis.man.torun.pl>
References: <nemoFri121407105527@flis.man.torun.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?RmzDoXZpbw==?= Pires <flavio.defreitas@gmail.com>
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org

On Fri, 14 Dec 2007 15:34:10 +0000 (UTC)
Flávio Pires <flavio.defreitas@gmail.com> wrote:

> Hi all, 
> 
> It's my first time using usenet...
> 
> Well, I work on an ISP and we have a linux box acting as a
> bridge+firewall. With this bridge+firewall we control the packet rate
> per second from each client and from our repeaters. But I can`t
> measure the packet rate per IP. Is there any tool for this?
> 
> Actually, what I want is to measure the packet rate per IP and
> generate graphics with mrtg or rrdtool, but for this I must have the
> number of packets per second of each client :)
> 
> Thank you all
> --
> Flávio
> 
> 


Not that I know of, but you might look at:
http://www.bandwidtharbitrator.com/
-- 
Stephen Hemminger <shemminger@linux-foundation.org>

