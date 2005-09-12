Message-ID: <43251154.8080209@osdl.org>
Date: Sun, 11 Sep 2005 22:25:40 -0700
From: Stephen Hemminger <shemminger@osdl.org>
MIME-Version: 1.0
Subject: Re: [Bridge] ioctl function definition?
References: <4120021E9E68D345810AD6B696DCA8E80E7FDC@icex4.ic.ac.uk>
In-Reply-To: <4120021E9E68D345810AD6B696DCA8E80E7FDC@icex4.ic.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Ahsan, Ahmad" <ahmad.ahsan@imperial.ac.uk>
Cc: bridge@lists.osdl.org

Ahsan, Ahmad wrote:

> hi!
>  
> i have read the bridge source code, in order to modify the bridge so 
> that it acts as a bridge + firewall in one. in this way, the firewall 
> would be faster as data does not have to go up to the application 
> layer, but only need to go up to the data link layer (where the bridge 
> works).
>  

That is what ebtables already does!
