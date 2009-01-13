Date: Tue, 13 Jan 2009 00:25:50 +0000 (GMT)
From: Simon Detheridge <simon@widgit.com>
Message-ID: <2112580130.119481231806350173.JavaMail.root@ken>
In-Reply-To: <1107190142.119461231806153899.JavaMail.root@ken>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Prevent MAC address from changing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: bridge@lists.linux-foundation.org

----- "Stephen Hemminger" <shemminger@vyatta.com> wrote:

> If you manually configure an MAC address, it sticks as of 2.6.27

*sigh* - This was what I tried to do, but it didn't work. Obviously my kernel is too old.

I'm on Amazon EC2, which is stuck on 2.6.21 right now (at least in Europe, which is where I'm trying to host my application). 

I tried listening on dummy0 instead, but it turns out a dummy interface is not a real interface and my packets go nowhere. 

veth might be perfect for what I'm trying to do (it makes a bit more sense than an IP address assigned to the bridge) but again my kernel is too old.

None of these issues are a problem for this list, however.

Thanks for the help,
Simon

-- 
Simon Detheridge - CTO, Widgit Software
26 Queen Street, Cubbington, CV32 7NA - Tel: +44 (0)1926 333680
