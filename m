Date: Fri, 11 Mar 2005 09:38:57 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20050311093857.42785b5d@dxpl.pdx.osdl.net>
In-Reply-To: <4231AF70.7000005@agro.uba.ar>
References: <4231AF70.7000005@agro.uba.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: Virtual IP
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Mariano Wahlmann <wahlmann@agro.uba.ar>, bridge@osdl.org

On Fri, 11 Mar 2005 11:47:12 -0300
Mariano Wahlmann <wahlmann@agro.uba.ar> wrote:

> hi, i'm trying brigde to use with qemu. my configuration is one 
> interface eth0 with two virtual ips 168.96.156.X and 10.1.1.X, but when 
> i use brigde i can only use one ip for br0 do you know how can i create 
> bridge br0 (to be used with qemu) and mantein my two ip's address config?.
> 
> Thanks

no, i don't know the answer.  the bridge device really doesn't know
anything about ip.  If you can do it for any other device (for example dummy),
then you should be able to do it for bridge.
