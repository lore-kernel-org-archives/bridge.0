From: Nick Fedchik <nick@fedchik.org.ua>
Reply-To: nick@fedchik.org.ua
Subject: Re: [Bridge] ebtables?
Date: Thu, 24 Jul 2003 09:16:23 +0400
References: <3F1EE540.4050909@datajunction.com>
In-Reply-To: <3F1EE540.4050909@datajunction.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-u"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307240916.23515.nick@fedchik.org.ua>
Sender: bridge-admin@lists.osdl.org
Errors-To: bridge-admin@lists.osdl.org
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge/>
To: bridge@lists.osdl.org

On Wednesday 23 July 2003 23:42, David Barcelo wrote:
> What is the point of ebtables?  
See to http://ebtables.sourceforge.net/

> Why would I need it?
Who know why?... ;)
To filter ethernet frames (on link Layer), but not only an ip packets 
(on Network Layer) on Your Linux-powered bridge (because bridge is [mostly] 
Layer 2 (Linkk Layer) device)

> Does it offer any features over iptables for just IP users?
See the iptables/ebtables interaction:
http://ebtables.sourceforge.net/br_fw_ia/br_fw_ia.html

> Does that mean (and I think it does) that without ebtables IPX traffic 
would pass a bridge, such as the one this list is for, uninhibited?
http://ebtables.sourceforge.net/documentation.html#what

-- 
Best regards, Nick Fedchik
FNM3-RIPE(-UANIC) http://www.fedchik.org.ua

