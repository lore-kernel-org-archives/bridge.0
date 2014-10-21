Return-Path: <oliver.graute@neuhaus.de>
Message-ID: <OF305789BF.DDFC2700-ONC1257D78.004C279D-C1257D78.004EAE6C@neuhaus.de>
From: Oliver.Graute@neuhaus.de
Date: Tue, 21 Oct 2014 16:19:20 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="----88042F448B38F3840E785F504DE1E5D7"
Subject: [Bridge] RSTP daemon and Marvel switch
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This is an S/MIME signed message

------88042F448B38F3840E785F504DE1E5D7
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBF7EBDFDFA10D8f9e8a93df938690918c4EBBF7EBDFDFA10D"
Content-Disposition: inline

--0__=4EBBF7EBDFDFA10D8f9e8a93df938690918c4EBBF7EBDFDFA10D
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable



Hello

I would like to use the RSTP daemon (kernel/git/shemminger/rstp.git)  o=
n a
embedded Linux system with an 7-Port  Fast Ethernet marvel switch Chip
(88EE6071).

But on my embedded Linux  system the switch is hidden behind one single=

"eth1" Interface.

The access to the individual switch ports is currently only possible vi=
a an
MII Interface (mii-diag tool). Via this Interface I can set manually so=
me
registers on the switch to put ports into the different states
(blocking/learning/forwarding etc.).
How and where do I adjust the rstp daemon (or the kernel?)  to handle t=
hese
states of the switch ports according to the Rapid Spanning Tree Protoco=
l?

Best regards,

Oliver Graute
=

--0__=4EBBF7EBDFDFA10D8f9e8a93df938690918c4EBBF7EBDFDFA10D
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p>Hello<br>
<br>
I would like to use the RSTP daemon (kernel/git/shemminger/rstp.git)  o=
n a embedded Linux system with an 7-Port  Fast Ethernet marvel switch C=
hip (88EE6071). <br>
<br>
But on my embedded Linux  system the switch is hidden behind one single=
 &quot;eth1&quot; Interface.  <br>
<br>
The access to the individual switch ports is currently only possible vi=
a an MII Interface (mii-diag tool). Via this Interface I can set manual=
ly some registers on the switch to put ports into the different states =
 (blocking/learning/forwarding etc.).<br>
How and where do I adjust the rstp daemon (or the kernel?)  to handle t=
hese states of the switch ports according to the Rapid Spanning Tree Pr=
otocol?<br>
<br>
Best regards,<br>
<br>
Oliver Graute<br>
     </body></html>=

--0__=4EBBF7EBDFDFA10D8f9e8a93df938690918c4EBBF7EBDFDFA10D--

------88042F448B38F3840E785F504DE1E5D7
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIJYwYJKoZIhvcNAQcCoIIJVDCCCVACAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3
DQEHAaCCB2QwggOhMIICiaADAgECAgRTKpskMA0GCSqGSIb3DQEBBQUAMGUxGDAW
BgNVBAMTD2Z3MXQubmV1aGF1cy5kZTEQMA4GA1UECxMHR2F0ZXdheTEqMCgGA1UE
ChMhRHIgTmV1aGF1cyBUZWxla29tbXVuaWthdGlvbiBHbWJIMQswCQYDVQQGEwJk
ZTAeFw0xNDAzMjAwNzM5MTZaFw0zNDAzMTUwNzM5MTZaMIGMMQswCQYDVQQGEwJk
ZTEqMCgGA1UEChMhRHIgTmV1aGF1cyBUZWxla29tbXVuaWthdGlvbiBHbWJIMRAw
DgYDVQQLEwdHYXRld2F5MRYwFAYDVQQDEw1PbGl2ZXIgR3JhdXRlMScwJQYJKoZI
hvcNAQkBFhhPbGl2ZXIuR3JhdXRlQG5ldWhhdXMuZGUwgZ8wDQYJKoZIhvcNAQEB
BQADgY0AMIGJAoGBANnANTj15llaogP5PS5qQZfo8FpeQCMWO4RcCitX5G8OrTR+
bilKdhylqIRbb2J9eYbBgrhwRIJwk696ZB3N0eJhk4WHXarBXUx2CKqLuRymTSGZ
sIhWRkRUXUVc5067J4xL0/4yCj4+U7s+S7V/9bmQqB2Wk+if28tK6cGEpdIPAgMB
AAGjgbQwgbEwCQYDVR0TBAIwADARBglghkgBhvhCAQEEBAMCBLAwLAYJYIZIAYb4
QgENBB8WHU9wZW5TU0wgR2VuZXJhdGVkIENlcnRpZmljYXRlMB0GA1UdDgQWBBQ5
rpfOC5wJcJPg5vtZJ96Nt0UgKTAfBgNVHSMEGDAWgBTs+JXPYwn0sdl6NX256a/J
cW9YoDAjBgNVHREEHDAagRhPbGl2ZXIuR3JhdXRlQG5ldWhhdXMuZGUwDQYJKoZI
hvcNAQEFBQADggEBAHM02XacfrbOAa0f1e+HE940vZaE5xgEUPcOaTCe6Wdu3nK3
OGAGIAnHfQ130XKDW1/w2XY7EoSwK8IkGRN7PJY/oZ214mcBrMBa/oB2i3uhhV9J
bxG5cRnGyY10BpkFYag/6Jd9YI+4HjhKCDp/YB2MbslphU/Dw8c30qS/UOYzC5Ix
4QyN/qK6ykGnvJAV2K120IYiO3O8W4TpdloF0ZMUtExTpDgFgFQdLtDbaMVzAzxz
1nnncN6uf+Yd4B8Rz6H3xn4El5TYkyPCY/S0N0TBeFVih8pzh7g88YqfZMQ9msIS
SCCEl5BpLDHbwAaBV5cHjkrvbXO7RnO56tmZ9wcwggO7MIICo6ADAgECAhRTTkX+
umlHGjEnbVuCyKf7ZDxsAzANBgkqhkiG9w0BAQUFADBlMRgwFgYDVQQDEw9mdzF0
Lm5ldWhhdXMuZGUxEDAOBgNVBAsTB0dhdGV3YXkxKjAoBgNVBAoTIURyIE5ldWhh
dXMgVGVsZWtvbW11bmlrYXRpb24gR21iSDELMAkGA1UEBhMCZGUwHhcNMDcwMzE5
MTYyOTI5WhcNMjcwMzE0MTYyOTI5WjBlMRgwFgYDVQQDEw9mdzF0Lm5ldWhhdXMu
ZGUxEDAOBgNVBAsTB0dhdGV3YXkxKjAoBgNVBAoTIURyIE5ldWhhdXMgVGVsZWtv
bW11bmlrYXRpb24gR21iSDELMAkGA1UEBhMCZGUwggEiMA0GCSqGSIb3DQEBAQUA
A4IBDwAwggEKAoIBAQDO/vqAga4J46o9WABfVwTFOYiUyA7GMnRK5Nck4InVoQYy
Bd3kZGANQhSFocmiBd0ptwVaJ5CdZivSe1K/FzhNVygo5UyL2C85uqrb51H7pVFV
93yuB399V6sMnZnMYkoQpfbGdFfeQx2YlopLkvvJPQK8I9qbpK/XqjxHcnQh21d4
D890UWUAWGIDk4iwwyII75k32HJO2D+fiygjzfoT0azyEfoYH9jUSA3tk3wQX3N3
tCLxsCKta1TIaAyb7eUvXlk3rbrWh5UYVuUMaCo8tEC6mLvoG+gJbAhKePOV4DMM
OpplBXCw/bj2CXK7q/3TbJ507jO56EBt/q+7+nqpAgMBAAGjYzBhMA8GA1UdEwEB
/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBTs+JXPYwn0sdl6NX25
6a/JcW9YoDAfBgNVHSMEGDAWgBTs+JXPYwn0sdl6NX256a/JcW9YoDANBgkqhkiG
9w0BAQUFAAOCAQEARW5yvbZw9SgSKfhT+ty1dS3DSdMZdEs4BL2q7lGq/kWM5Wec
F2U4ygvUd/H2Bw4S7n566gTgMxarh0v3cxw36HqDlT1/ZNsPD1653WLDAVNe1/qu
RrTMRrXwABa/G9W7T4eOBjcjsX/id5NR3y9UPbbAkozx0TRSO16puxd8tMcAW/p2
zzueErvCJU5OwhGvbDgjhp0eXRKkifkyCeC9ETda8+FaZhKI9Wsq3FW0fONnYhQu
i4lIHNPbkLJuL3a10pRSgZamkjy/gTCeiNj2JyrpMD9SrSe/gxguAElQ5Z2xGlpN
vfWmJ8HR4vZBvGvfBq/1c5gjsHiCHVq9sHNdajGCAccwggHDAgEBMG0wZTEYMBYG
A1UEAxMPZncxdC5uZXVoYXVzLmRlMRAwDgYDVQQLEwdHYXRld2F5MSowKAYDVQQK
EyFEciBOZXVoYXVzIFRlbGVrb21tdW5pa2F0aW9uIEdtYkgxCzAJBgNVBAYTAmRl
AgRTKpskMAkGBSsOAwIaBQCggbEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMTQxMDIxMTQxOTI4WjAjBgkqhkiG9w0BCQQxFgQUVcYd
ZLivxsBSi4T5oxRwBfIRMRswUgYJKoZIhvcNAQkPMUUwQzAKBggqhkiG9w0DBzAO
BggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcN
AwICASgwDQYJKoZIhvcNAQEBBQAEgYDEWXW5c2yUI8LBTl+RrxzYB2pMUPV4eNv+
i2r4L46UghGcP+tneOnC0j+7aFcMstmcUrpJ1KkG+xQxZY1XI2NGs3JTeMnRGFz5
ugCWxmkXWScqkxhNgpQiAE2y3cbZS2fgK3qWvD920I1TnP1Zl8opUGY264DkjlFS
1zO3vGQthw==

------88042F448B38F3840E785F504DE1E5D7--

