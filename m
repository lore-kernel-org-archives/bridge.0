Date: Wed, 20 Dec 2006 14:32:09 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061220143209.7b83d097@dxpl.pdx.osdl.net>
In-Reply-To: <BAY104-F2142DB44B21DC4DEBEF1FEFDCF0@phx.gbl>
References: <BAY104-F2142DB44B21DC4DEBEF1FEFDCF0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Wed, 20 Dec 2006 21:26:18 +0000
"Jie Chen" <cj70286@hotmail.com> wrote:

> Hi everybody,
> 
> Just have myself added into the maillist. I have a few linux boxes with 
> Kernel 2.6.9. Each box has 2 ethernet interfaces, one 3COM, one Intel. I 
> connected one with Power Line Modem, and one with Wifi Modem. They form a 
> nice network with bridge. I have a few questions here.
> 
> Suppose I have two path from box A to box D, which path will packets go 
> through? If I want to monitor the condition (throughput) of each interface, 
> and pick the better one, how do I do it? If I want to use both interfaces to 
> transfer data, how do I do it?

With STP it will choose the "least cost" which is determined by the port
cost variable. In 2.6, it automatically sets the cost based on link speed. but
then you can change it later with brctl

> 
> Thanks in advance for your answers,
> cj
> 
> _________________________________________________________________
> Type your favorite song.  Get a customized station.  Try MSN Radio powered 
> by Pandora. http://radio.msn.com/?icid=T002MSN03A07001
> 

