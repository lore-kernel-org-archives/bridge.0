Date: Thu, 4 Jan 2007 13:03:16 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20070104130316.1147e9b6@freekitty>
In-Reply-To: <BAY104-F10CB67A9A63873CE6CE36DFDB80@phx.gbl>
References: <458ACFAC.6070006@schaus.ca>
	<BAY104-F10CB67A9A63873CE6CE36DFDB80@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Monitor the status of two ethernet interface
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Jie Chen <cj70286@hotmail.com>
Cc: bridge@lists.osdl.org

On Thu, 04 Jan 2007 20:39:12 +0000
"Jie Chen" <cj70286@hotmail.com> wrote:

> Hi all,
> 
> I hope everybody had a great holiday.
> 
> I got a question in applying ethernet bridge in Linux boxes. The scenario 
> I'm trying to simulate is like this:  I have 3 linux boxes in total, 
> everyone has 2 ethernet ports, one port is connected to Power line modem, 
> and the other to wifi modem. The power line modem failed, so it's the same 
> as I have just one port for each. I put them apart, Box A is in one end, and 
> Box C is in another end, and Box B in the middle, so that Box A can talk to 
> B but not C. Box B can talk to A and C. Box C and talk to B but not A. Now I 
> set bridge on, the question is am I able to let A and C talk?
> 
> The reason I have this question is according to bridge, B get packets from A 
> on one port, and suppose to deliver to C from the other port, but the other 
> port didn't work. So I would think the packets can't be delivered from A to 
> C, is that the case?
> 
> Thanks a lot,
> Jie
> 
>

True bridging to Wifi won't usually work see the http://linux-net.osdl.org/index.php/Bridge

The problem is that internally Wifi is not a Bus network like Ethernet, but
is really point-to-point from host to access point.


-- 
Stephen Hemminger <shemminger@osdl.org>
