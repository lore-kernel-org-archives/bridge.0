Date: Fri, 1 Apr 2005 09:07:08 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] bridge problem, please help me
Message-ID: <20050401090708.03b12fe2@dxpl.pdx.osdl.net>
In-Reply-To: <000601c536b7$6d2bcfb0$0b05a8c0@suzo>
References: <000601c536b7$6d2bcfb0$0b05a8c0@suzo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: zok <zok@suzo.sk>
Cc: bridge@lists.osdl.org

On Fri, 1 Apr 2005 14:36:27 +0200
"zok" <zok@suzo.sk> wrote:

> I'm a problem with bridge please help me
> 
> My configuration:
> 
> eth0,eth1,wlan0
> 
> bridge is br0 on devices eth0 and wlan0. Device eth1 is not in bridge.
> 
> br0 ip is 192.168.1.1
> eth1 ip is 192.168.2.1
> 
> ethernet (eth0,eth1) is in one switch.
> 
> all is ok if eth1 not in system, if eth1 plugged into system and up interface eth1 network crash :(

You don't want to assign IP address to eth1 unless you are doing other things
to turn the configuration into a brouter.

