Date: Tue, 8 Aug 2006 11:30:25 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060808113025.6dc41308@localhost.localdomain>
In-Reply-To: <116823230608072305g1ef9f73la91213524d74b17c@mail.gmail.com>
References: <449AA3EF.9080300@kingsley.co.za>
	<20060707114918.26b099ba@dxpl.pdx.osdl.net>
	<116823230608072305g1ef9f73la91213524d74b17c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Network seperation and ethernet bridge...
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "He, Zhenjie" <hezhenjie@gmail.com>
Cc: bridge@lists.osdl.org

On Tue, 8 Aug 2006 14:05:03 +0800
"He, Zhenjie" <hezhenjie@gmail.com> wrote:

> Hi, Stephen/all,
> 
> The situation I meet is similar as this.
> 
> I want to capture BPDU packets go through the Linux bridge,

Simpler just to use something like AF_PACKET, or tools like pcapture?

> 
> [internal bridge] --> (connected with a switch) --> [external bridge] -->
> workstation,
> 
> [internal bridge]: br1 ip.addr == 192.168.1.2
> [external bridge]: ifconfig br0 192.168.1.10 netmask 255.255.255.0 up
> workstation: ip.addr == 192.168.1.222
> enable the [internal bridge] with stp on,
> 
> My question is, could [internal bridge] generate BPDU packets, and pass the
> [external bridge], finally captured on the outside workstation?
> 
> Best regards,

Nested bridges are not supported because of possible stack depth and recursion
issues.
