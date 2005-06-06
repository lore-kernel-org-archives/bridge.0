Subject: Re: [Bridge] persistent settings
From: Jeremy Jones <jjones@djc.state.id.us>
In-Reply-To: <42A3B066.60600@secure-mind.net>
References: <42A3B066.60600@secure-mind.net>
Content-Type: text/plain
Date: Mon, 06 Jun 2005 11:39:48 -0600
Message-Id: <1118079588.21081.10.camel@jjones-lnx.idjc.idaho.gov>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,

On Sun, 2005-06-05 at 22:09 -0400, Hugh Crissman wrote:
> Google did not turn up much on this so I figured I would come to the 
> source. I got my bridge working great. I wanted to know, how do I make 
> the setting persistent? So when I reboot the machine, the bridge comes 
> up and is operational automatically. Basically I followed the directions 
> off of the site. I am not running STP. My bridge does have a private ip.

Add all the commands you run to build your bridge to a script & execute
that script when you startup.  Look for a file somewhere in /etc called,
say, rc.local.  Really, where you put the commands depends on your
distro.

Jeremy

